module Mutations
    class UpdateUser < BaseMutation
      argument :email, String, required: false
      argument :password, String, required: false
      argument :name, String, required: false
      argument :balance, Float, required: false

      type Types::UserType

      def resolve(email: nil, password: nil, name:nil, balance:nil)
        authorized_user

        context[:current_user].email = email if email.present?
        context[:current_user].password = password if password.present?
        context[:current_user].name = name if name.present?
        context[:current_user].balance = balance if balance.present?
        context[:current_user].save!

        raise GraphQL::ExecutionError, context[:current_user].errors.full_messages.join(', ') unless context[:current_user].errors.empty?
        context[:current_user]
      rescue ActiveRecord::RecordInvalid
        GraphQL::ExecutionError.new('ERROR: Username or email is taken')
      end
    end
end
