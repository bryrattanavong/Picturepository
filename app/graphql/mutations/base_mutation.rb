module Mutations
  class Mutations::BaseMutation < GraphQL::Schema::Mutation
    def authorized_user
      return if context[:current_user]
      raise ExceptionHandler::InvalidToken, 'Token verification failed'
    end
  end
end