require 'rails_helper'
RSpec.describe('Purchase queries') do
    before do
        @user = create(:user, email: 'tester@email.com', name: 'billy', password: '1234', balance:1230.00)
        @user2 = create(:user, email: 'tester2@email.com', name: 'billy', password: '1234', balance:1230.00)
        @image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @user.id)
    end
  describe Queries::Purchase do
    it 'Query an purchase' do
      purchase = create(:purchase,id:@image.id, title:"hello",description:"test", cost:12.00,user_id: @user.id, seller_id: @user2.id)

      query = <<~GRAPHQL
        query purchase($id: ID!) {
          purchase(id: $id){
              id
          }
        }
        GRAPHQL

      vars = {
        id: @image.id,
      }

      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['purchase']["id"].to_i).to(eq(purchase.id))
    
    end
  end
end