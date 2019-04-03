RSpec.describe Chakin do
  it "has a version number" do
    expect(Chakin::VERSION).not_to be nil
  end

  it "prints word vectors" do
    Chakin::Vectors.search('English')
  end

  it "downloads word vectors" do
    Chakin::Vectors.download(number: 17, save_dir: './')
  end
end
