require 'rails_helper'
RSpec.describe('Image queries') do
    before do
        @user = create(:user, email: 'tester@email.com', name: 'something', password: '1234', balance:1230.00)
    end
  describe Queries::Images do
    it 'Query an image' do
      
      image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)

      query = <<~GRAPHQL
        query image($id: ID!) {
          image(id: $id){
              id
          }
        }
        GRAPHQL

      vars = {
        id: image.id,
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['image']["id"].to_i).to(eq(image.id))
    
    end
    it 'Query multiple public images' do
      
        image1 = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)
        image2 = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)
        image3 = create(:image, title: "hello", description:"test", price:12.00, private: true, user_id: @user.id)
  
        query = <<~GRAPHQL
          query images($first: Int!) {
            images(first: $first){
                nodes{
                    id
                }
            }
          }
          GRAPHQL
  
        vars = {
          first:3,
        }
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @user},
          variables: vars
        )
        expect(result['data']['images']["nodes"].length).to(eq(2))
      
      end
  end
end