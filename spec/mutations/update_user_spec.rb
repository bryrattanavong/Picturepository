require 'rails_helper'
RSpec.describe('Update Image') do
    before do
        @user = create(:user, email: 'user@email.com', name: 'something', password: '1234', balance:1230.00)
        @tester = create(:user, email: 'tester@email.com', name: 'something', password: '1234', balance:1230.00)
    end
  describe Mutations::UpdateUser do
    it 'Update an image ' do
      
      query = <<~GRAPHQL
        mutation updateUser( $name: String!) {
          updateUser( name: $name){
                name
          }
        }
        GRAPHQL

      vars = {
        name: 'Tester',
      }
      result =  ImageexplorerapiSchema.execute(
        query,
        context: {current_user: @user},
        variables: vars
      )
    
      expect(result['data']['updateUser']['name']).to(eq('Tester'))
    end
    it 'unsuccesfuly update an image ' do
      
        query = <<~GRAPHQL
          mutation updateUser( $email: String!) {
            updateUser( email: $email){
                email
            }
          }
          GRAPHQL
  
        vars = {
          email: 'tester@email.com',
        }
        result =  ImageexplorerapiSchema.execute(
          query,
          context: {current_user: @user},
          variables: vars
        )
      
        expect(result['errors'][0]['message']).to(eq('Error: Email is taken'))
      end
  end
end