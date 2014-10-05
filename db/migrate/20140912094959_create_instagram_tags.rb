class CreateInstagramTags < ActiveRecord::Migration
  def change
    create_table :instagram_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
