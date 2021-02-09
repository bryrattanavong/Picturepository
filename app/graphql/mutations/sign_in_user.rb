module Mutations
  class SignInUser < BaseMutation
    null true
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email: nil, password: nil)
      
      unless user = User.find_by(email:email)
        return GraphQL::ExecutionError.new("Error: no user with that email.");
      end

      return unless user.authenticate(password)
      user_id = { id: user.id }
      crypt = JWT.encode(user_id,Rails.application.secrets.secret_key_base.byteslice(0..31))
      
      { user: user, token: crypt }
    end
  end
end