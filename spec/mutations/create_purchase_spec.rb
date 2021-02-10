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
          createPurchase(id: $id){
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
      expect(result['data']['createPurchase']["id"].to_i).to(eq(Purchase.last.id))
    
    end
    it 'Create a purchase with a discount' do
      
      image = create(:image, title: "hello", description:"test", price:8.00, private: false, user_id: @newuser.id)

      query = <<~GRAPHQL
        mutation createPurchase($id: ID!, $discount: Float!) {
          createPurchase(id: $id, discount: $discount){
            id
            cost
            user{
              balance
            }
          }
        }
        GRAPHQL

      vars = {
        id: image.id,
        discount: 10.00
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['createPurchase']["user"]["balance"]).to(eq(1222.80))
    
    end

    it 'Create a purchase with a >100 discount' do
      image = create(:image, title: "hello", description:"test", price:8.00, private: false, user_id: @newuser.id)

      query = <<~GRAPHQL
        mutation createPurchase($id: ID!, $discount: Float!) {
          createPurchase(id: $id, discount: $discount){
            id
            cost
          }
        }
        GRAPHQL

      vars = {
        id: image.id,
        discount: 101
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['errors'][0]['message']).to(eq("ERROR: discount cant be greater than 100"))
    
    end

    it 'Create a purchase with a 0< discount' do
      image = create(:image, title: "hello", description:"test", price:8.00, private: false, user_id: @newuser.id)

      query = <<~GRAPHQL
        mutation createPurchase($id: ID!, $discount: Float!) {
          createPurchase(id: $id, discount: $discount){
            id
            cost
          }
        }
        GRAPHQL

      vars = {
        id: image.id,
        discount: -1
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['errors'][0]['message']).to(eq("ERROR: discount cant be less than 0"))
    
    end

    it 'Create a purchase user cannot afford' do
      
        image = create(:image, title: "hello", description:"test", price:12.00, private: false, user_id: @newuser.id)
  
        query = <<~GRAPHQL
          mutation createPurchase($id: ID!) {
            createPurchase(id: $id){
              id
            }
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
            createPurchase(id: $id){
              id
            }
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
            createPurchase(id: $id){
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
        expect(result['errors'][0]['message']).to(eq("ERROR: Requested Image is either private or does not exist"))
      
    end
  end
end