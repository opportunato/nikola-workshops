class AddMinPrice < ActiveRecord::Migration
  def change
    change_table :workshops do |t|
      t.boolean :is_price_min, default: false
    end
  end
end
