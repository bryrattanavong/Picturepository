module Types
  class MutationType < Types::BaseObject
    field :sign_up_user, mutation: Mutations::SignUpUser, description: 'Create a user'
    field :sign_in_user, mutation: Mutations::SignInUser, description: 'Signs in a user'
    field :update_user, mutation: Mutations::UpdateUser, description: 'Updates a user'
    field :create_image, mutation: Mutations::CreateImage, description: 'Create a image'
    field :delete_image, mutation: Mutations::DeleteImage, description: 'Delete a image'
    field :update_image, mutation: Mutations::UpdateImage, description: 'Updates a image'
    field :create_purchase, mutation: Mutations::CreatePurchase, description: 'Creates a purchase '
  end
end
