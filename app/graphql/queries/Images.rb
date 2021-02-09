module Queries
  class Images < BaseQuery
    argument :page, Integer, required: true
    argument :limit, Integer, required: true
    type Types::ImageType.connection_type, null: false

    def resolve(page:, limit:)
     ::Image.where(private: false).order(id: :asc).page(page).per(limit)
    end
  end
end