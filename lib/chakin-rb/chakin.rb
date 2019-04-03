require "chakin-rb/version"
require 'csv'
require 'daru'
require 'ruby-progressbar'
require 'net/http'
require 'fileutils'

module Chakin
  class HttpRedirect < StandardError
    attr_reader :new_url
    def initialize(new_url)
      @new_url = new_url
    end
  end
  class Error < StandardError; end
  module Downloader
    def load_datasets(path = File.join(__dir__, 'datasets.csv'))
      Daru::DataFrame.from_csv(path)
    end

    ##
    # Download pre-trained word vector
    def download(number: nil, name: '', save_dir: './')
      df = load_datasets

      row = if !number.nil?
              df.row[number]
            elsif name
              df.df.where(df['Name'].eq(name))
            end

      url = row['URL']
      raise 'The word vector you specified was not found. Please specify correct name.' if url.nil?


      file_name = url.split('/')[-1]

      FileUtils.mkdir_p(save_dir) unless File.exist?(save_dir)

      save_path = File.join(save_dir, file_name)
      begin
        download_file(save_path, url)
      rescue Chakin::HttpRedirect => e
        download_file(save_path, e.new_url)
      end
      save_path
    end

    def download_file(save_path, url)
      progressbar = ProgressBar.create

      f = File.open(save_path, 'wb')
      begin
        my_uri = URI.parse(url)
        http = Net::HTTP.new(my_uri.host, my_uri.port)

        if my_uri.instance_of?(URI::HTTPS)
          http.use_ssl = true
        end

        http.request_get(my_uri.path) do |resp|
          total_size = resp.content_length
          progressbar.total = total_size

          if resp.code == "302"
            raise HttpRedirect.new(resp.header['Location'])
          end
          resp.read_body do |segment|
            progressbar.progress += segment.size
            f.write(segment)
          end
        end
      ensure
        f.close
      end
    end

    def search(lang = '')
      df = load_datasets
      if lang == ''
        puts df.inspect
      else
        rows = df.where(df['Language'].eq(lang))
        puts rows['Name', 'Dimension', 'Corpus', 'VocabularySize', 'Method', 'Language', 'Author'].inspect
      end
    end
  end

  class Vectors
    extend Downloader
  end
end