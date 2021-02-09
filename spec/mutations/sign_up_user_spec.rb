require 'rails_helper'
RSpec.describe('Create user') do
    before do
        @user = create(:user, email: 'tester@email.com', name: 'billy', password: '1234', balance:1230.00)
    end
  describe Mutations::SignUpUser do
    it 'Create a user successfully' do
      

      query = <<~GRAPHQL
        mutation signUpUser($email: String!, $password: String!, $name: String!, $balance: Float!) {
            signUpUser(email: $email, password: $password, name: $name, balance: $balance){
            id
          }
        }
        GRAPHQL

      vars = {
        email: 'test@email.com',
        password: '1234',
        name: 'bob',
        balance: 12.32
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['signUpUser']['id'].to_i).to(eq(User.last.id))
    
    end
        it 'Attempt to sign up existing a user' do
          
    
          query = <<~GRAPHQL
            mutation signUpUser($email: String!, $password: String!, $name: String!, $balance: Float!) {
                signUpUser(email: $email, password: $password, name: $name, balance: $balance){
                id
              }
            }
            GRAPHQL
    
          vars = {
            email: 'tester@email.com',
            password: '1234',
            name: 'billy',
            balance: 12.32
          }
          result =  ImageexplorerapiSchema.execute(
            query,
            context: {current_user: @user},
            variables: vars
          )
          expect(result['errors'][0]['message']).to(eq("ERROR: email already used by other user"))
    end
  end
end