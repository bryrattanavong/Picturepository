module Types
  class QueryType < Types::BaseObject
    field :image, resolver: Queries::Image, description: 'Get a image by id'
    field :images, resolver: Queries::Images, description: 'Get all image'
    field :search_images, resolver: Queries::SearchImages, description: 'Search images'
    field :user, resolver: Queries::User, description: 'Get a user by id'
    field :users, resolver: Queries::Users, description: 'Get all users'
    field :purchase, resolver: Queries::Purchase, description: 'Get a purchase by id'
    
  end
end