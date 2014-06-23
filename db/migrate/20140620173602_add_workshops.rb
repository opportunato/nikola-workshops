class AddWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :title
      t.string :headline
      t.text :description
      t.text :program
      t.integer :price
      t.string :buy_link
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.boolean :is_published, default: false

      t.timestamps
    end

    add_index :workshops, :start_date
  end
end
