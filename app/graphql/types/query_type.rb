module Types
  class QueryType < Types::BaseObject
    field :image, resolver: Queries::Image, description: 'Get a image by id'
    field :images, resolver: Queries::Images, description: 'Get all image'
    field :search_images, resolver: Queries::SearchImages, description: 'Search images'
    field :hash_tags, resolver: Queries::HashTags, description: 'Get all hashtags'
    field :user, resolver: Queries::User, description: 'Get a user by id'
    field :users, resolver: Queries::User, description: 'Get a user by id'
    field :purchase, resolver: Queries::Purchase, description: 'Get a purchase by id'
  end
end