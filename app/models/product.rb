class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_rich_text :description
  has_one_attached :image
  belongs_to :category
  belongs_to :subcategory
  serialize :colors, JSON
  serialize :sizes, JSON
  #  serialize :colors, Array
  # serialize :sizes, Array

  def self.search(query)
    return Product.all unless query.present?

    Product.__elasticsearch__.search(
      {
        query: {
          bool: {
            must: [
              {
                wildcard: {
                  name: {
                    value: "#{query}*",
                    case_insensitive: true
                  }
                }
              }
            ]
          }
        }
      }
    ).records
  end
end
