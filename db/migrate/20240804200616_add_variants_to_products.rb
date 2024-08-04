class AddVariantsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :variants, :jsonb, default: { colors: [], sizes: [] }
  end
end
