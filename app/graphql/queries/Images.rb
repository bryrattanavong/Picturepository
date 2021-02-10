module Queries
  class Images < BaseQuery

    type Types::ImageType.connection_type, null: false

    def resolve
     ::Image.where(private: false).all
    end
  end
end