module Mutations
    class UpdateUser < BaseMutation
      argument :email, String, required: false
      argument :password, String, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false

      type Types::UserType

      def resolve(email: nil, password: nil, first_name: nil, last_name: nil)
        authorized_user

        context[:current_user].email = email if email.present?
        context[:current_user].password = password if password.present?
        context[:current_user].first_name = first_name if first_name.present?
        context[:current_user].last_name = last_name if last_name.present?
        context[:current_user].save!

        raise GraphQL::ExecutionError, user.errors.full_messages.join(', ') unless user.errors.empty?

        user
      end
    end
end
