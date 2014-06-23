class AddHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name
      t.text :description
      t.references :workshop, null: false
      t.string :link

      t.timestamps
    end

    add_index :hosts, :workshop_id
  end
end
