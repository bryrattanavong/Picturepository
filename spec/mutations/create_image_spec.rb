require 'rails_helper'
RSpec.describe('Create Image') do
    before do
        @user = create(:user, email: 'user@email.com', name: 'billy', password: '1234', balance:1230.00)
    end
  describe Mutations::CreateImage do
    it 'create an image successfully' do

      query = <<~GRAPHQL
        mutation createImage($title: String!, $description: String!,  $price: Float!, $image: File!) {
          createImage(title: $title, description: $description, private: false, price: $price, image: $image){
              id
          }
        }
        GRAPHQL

        file = Tempfile.open("#{Rails.root}/spec/image/example.jpg")
        upload = ActionDispatch::Http::UploadedFile.new(
          filename: 'example.jpg',
          type: 'image/jpg',
          tempfile: file
        )

      vars = {
        title: 'Test Image',
        description: "test",
        price: 1.00,
        image: upload
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['createImage']['id'].to_i).to(eq(Image.last.id))

    end
    it 'fail an image create' do

        query = <<~GRAPHQL
          mutation createImage($title: String!, $description: String!,  $price: Float! ) {
            createImage(title: $title, description: $description, private: false, price: $price){
                id
            }
          }
          GRAPHQL
  
        vars = {
          title: 'Test Image',
          description: '"test"',
          price: 1.00,
        }
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @user},
          variables: vars
        )
        expect(result['errors'][0]['message']).to(eq("Field 'createImage' is missing required arguments: image"))
      end
  end
end