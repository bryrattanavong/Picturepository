require 'rails_helper'
RSpec.describe('user queries') do
    before do
        @user = create(:user, email: 'tester@email.com', name: 'billy', password: '1234', balance:1230.00)
        @user2 = create(:user, email: 'tester2@email.com', name: 'billy', password: '1234', balance:1230.00)
        @image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)
    end
  describe Queries::Users do
    it 'Query a User' do

      query = <<~GRAPHQL
        query user($id: ID!) {
          user(id: $id){
              id
          }
        }
        GRAPHQL

      vars = {
        id: @user.id,
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['user']["id"].to_i).to(eq(@user.id))
    
    end
    it 'Query multiple User' do

        query = <<~GRAPHQL
          query users($first: Int!) {
            users(first:$first){
                nodes{
                    id
                }
            }
          }
          GRAPHQL
  
        vars = {
          first: 2
        }
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @user},
          variables: vars
        )
        expect(result['data']['users']["nodes"].length).to(eq(2))
      
      end
  end
end