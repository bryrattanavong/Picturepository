require 'rails_helper'
RSpec.describe('Delete Image') do
    before do
        @user = create(:user, email: 'user@email.com', name: 'billy', password: '1234', balance:1230.00)
        @tester = create(:user, email: 'user1@email.com', name: 'tester', password: '1234', balance:1230.00)
    end
  describe Mutations::DeleteImage do
    it 'Delete an image' do

      image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)

      query = <<~GRAPHQL
        mutation deleteImage($id: Int!) {
          deleteImage(id: $id){
              image{
                  id
              }
          }
        }
        GRAPHQL

        vars = {
            id: image.id
          }

      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['deleteImage']['image']['id'].to_i).to(eq(image.id))

    end
    it 'Delete an image' do

        image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)
  
        query = <<~GRAPHQL
          mutation deleteImage($id: Int!) {
            deleteImage(id: $id){
                image{
                    id
                }
            }
          }
          GRAPHQL
  
          vars = {
              id: image.id
            }
  
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @tester},
          variables: vars
        )
        expect(result['errors'][0]['message']).to(eq("ERROR: User is not the owner of this Image"))
  
      end
      it 'Delete an image that does not exist' do

        image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)
  
        query = <<~GRAPHQL
          mutation deleteImage($id: Int!) {
            deleteImage(id: $id){
                image{
                    id
                }
            }
          }
          GRAPHQL
  
          vars = {
              id: 0
            }
  
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @tester},
          variables: vars
        )
        expect(result['errors'][0]['message']).to(eq("ERROR: Does not exist"))
  
      end
  end
end