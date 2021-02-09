require 'rails_helper'
RSpec.describe('Create user') do
    before do
        @user = create(:user, email: 'tester@email.com', name: 'billy', password: '1234', balance:1230.00)
    end
  describe Mutations::SignInUser do
    it 'Sign in a user successfully' do
      

      query = <<~GRAPHQL
        mutation signInUser($email: String!, $password: String!) {
            signInUser(email: $email, password: $password){
                user{
                    id
                }
          }
        }
        GRAPHQL

      vars = {
        email: 'tester@email.com',
        password: '1234',
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
      expect(result['data']['signInUser']['user']['id'].to_i).to(eq(@user.id))
    
    end
        it 'Attempt to sign in using a wrong email' do
          
    
          query = <<~GRAPHQL
            mutation signInUser($email: String!, $password: String!) {
                signInUser(email: $email, password: $password){
                    user{
                        id
                    }
              }
            }
            GRAPHQL
    
          vars = {
            email: 'testr@email.com',
            password: '1234',
          }
          result =  ImageexplorerapiSchema.execute(
            query,
            context: {current_user: @user},
            variables: vars
          )
          expect(result['errors'][0]['message']).to(eq("Error: no user with that email."))
    end
  end
end