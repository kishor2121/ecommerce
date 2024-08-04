class Category < ApplicationRecord
    has_many :products
    has_many :subcategories, dependent: :destroy
    # belongs_to :parent, class_name: 'Category', optional: true
  end
  