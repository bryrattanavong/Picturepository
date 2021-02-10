module Types
  class QueryType < Types::BaseObject
    field :image, resolver: Queries::Image, description: 'Get a image by id'
    field :images, resolver: Queries::Images, description: 'Get all public image'
    field :search_images, resolver: Queries::SearchImages, description: 'Search public images'
    field :user, resolver: Queries::User, description: 'Get a user by id'
    field :users, resolver: Queries::Users, description: 'Get all users'
    field :purchase, resolver: Queries::Purchase, description: 'Get a purchase by id'
    field :purchases, resolver: Queries::Purchases, description: 'Get all purchase'
  end
end