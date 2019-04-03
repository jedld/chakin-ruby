require "chakin-rb/version"
require 'csv'
require 'daru'
require 'ruby-progressbar'
require 'net/http'

module Chakin
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

      progressbar = ProgressBar.create
      file_name = url.split('/')[-1]

      File.mkdir(save_dir) unless File.exist?(save_dir)

      save_path = File.join(save_dir, file_name)

      f = File.open(save_path, 'wb')
      begin
        my_uri = URI.parse(url)

        Net::HTTP.start(my_uri.host) do |http|
          http.request_get(my_uri.path) do |resp|
            total_size = resp.content_length
            progressbar.total = total_size

            resp.read_body do |segment|
              progressbar.progress += segment.size
              f.write(segment)
            end
          end
        end
      ensure
        f.close
      end

      save_path
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