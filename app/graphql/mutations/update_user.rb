module Mutations
    class UpdateUser < BaseMutation
      argument :email, String, required: false
      argument :password, String, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false

      type Types::UserType

      def resolve(email: nil, password: nil, first_name: nil, last_name: nil)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?

        user.email = email if email.present?
        user.password = password if password.present?
        user.first_name = first_name if first_name.present?
        user.last_name = last_name if last_name.present?
        user.save!

        raise GraphQL::ExecutionError, user.errors.full_messages.join(', ') unless user.errors.empty?

        user
      end
    end
end
