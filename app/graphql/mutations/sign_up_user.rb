module Mutations
  class SignUpUser < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :name, String, required: true

    type Types::UserType

    def resolve(email:, password:, name:)
      return GraphQL::ExecutionError.new('ERROR: email already used by other user') unless User.where(email: email).empty?

      user = User.create!(
        name: name,
        email: email,
        password: password,
        balance: 100.00
      )

      raise GraphQL::ExecutionError, user.errors.full_messages.join(', ') unless user.errors.empty?

      user
    end
  end
end
