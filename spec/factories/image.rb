FactoryBot.define do
    factory :image do
      title { "test" }
      description { "test" }
      price { 12.34 }
      private { false }
      attached_image { Rack::Test::UploadedFile.new('spec/image/example.jpg', 'example.jpg') }
    end
  end