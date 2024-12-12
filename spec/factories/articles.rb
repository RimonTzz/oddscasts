# spec/factories/articles.rb
FactoryBot.define do
  factory :article do
    title { "Sample Article" }
    description { "Sample Description" }
    # cover { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixture/file/test_image.png'), 'image/png') }
    # association :content, factory: :content
    content { build(:content) }
  end
end
