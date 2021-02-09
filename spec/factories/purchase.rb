FactoryBot.define do
    factory :purchase do
      title { "test"}
      description { "test" }
      cost { 12.34 }
      attached_image { Rack::Test::UploadedFile.new('spec/image/example.jpg', 'example.jpg') }
    end
  end