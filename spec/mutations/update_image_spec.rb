require 'rails_helper'
RSpec.describe('Update Image') do
    before do
        @user = create(:user, email: 'user@email.com', name: 'something', password: '1234', balance:1230.00)
        @tester = create(:user, email: 'tester@email.com', name: 'something', password: '1234', balance:1230.00)
    end
  describe Mutations::UpdateImage do
    it 'Update an image ' do
      
      image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)

      query = <<~GRAPHQL
        mutation updateImage($id: ID!, $title: String!, $description: String!) {
          updateImage(id: $id, title: $title, description: $description){
                id
                title
                description
          }
        }
        GRAPHQL

      vars = {
        id: image.id,
        title: 'Test Image',
        description: "test",
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
    
      expect(result['data']['updateImage']['title']).to(eq('Test Image'))
      expect(result['data']['updateImage']['description']).to(eq("test"))
    end
    it 'Update image not owned' do
        image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @tester.id)

      query = <<~GRAPHQL
        mutation updateImage($id: ID!, $title: String!) {
          updateImage(id: $id, title: $title){
                id
                title
                description
          }
        }
        GRAPHQL

      vars = {
        id: image.id,
        title: "title",
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
    
      expect(result['errors'][0]['message']).to(eq("ERROR: Not owner of image"))
    end
  end
end