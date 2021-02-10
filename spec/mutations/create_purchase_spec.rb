require 'rails_helper'
RSpec.describe('Create purchase') do
    before do
        @user = create(:user, email: 'tester@email.com', name: 'billy', password: '1234', balance:1230.00)
        @newuser = create(:user, email: 'tester1@email.com', name: 'kenny', password: '1234', balance:1230.00)
        @tester = create(:user, email: 'tester2@email.com', name: 'jenny', password: '1234', balance:10.00)
    end
  describe Mutations::CreatePurchase do
    it 'Create a purchase successfully' do
      
      image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @newuser.id)

      query = <<~GRAPHQL
        mutation createPurchase($id: ID!) {
          createPurchase(id: $id)
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
      expect(result['data']['createPurchase']).to(eq('Purchased complete.'))
    
    end
    it 'Create a purchase user cannot afford' do
      
        image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @newuser.id)
  
        query = <<~GRAPHQL
          mutation createPurchase($id: ID!) {
            createPurchase(id: $id)
          }
          GRAPHQL
  
        vars = {
          id: image.id,
        }
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @tester},
          variables: vars
        )
        expect(result['errors'][0]['message']).to(eq("ERROR: User cannot afford this purchase"))
      
      end
    it 'Create a purchase user cannot afford' do
      
        image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @newuser.id)
  
        query = <<~GRAPHQL
          mutation createPurchase($id: ID!) {
            createPurchase(id: $id)
          }
          GRAPHQL
  
        vars = {
          id: image.id,
        }
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @newuser},
          variables: vars
        )
        expect(result['errors'][0]['message']).to(eq("ERROR: User cannot purchase own Image"))
      
    end
    it 'Create a private purchase' do
      
        image = create(:image, title: "hello", description:"test", price:12.00, private: true, user_id: @newuser.id)
  
        query = <<~GRAPHQL
          mutation createPurchase($id: ID!) {
            createPurchase(id: $id)
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
        expect(result['errors'][0]['message']).to(eq("ERROR: Requested Image is either private or does not exist"))
      
    end
  end
end