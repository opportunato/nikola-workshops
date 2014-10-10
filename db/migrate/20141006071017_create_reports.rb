class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
      t.string :slug
      t.integer :number
      t.text :text
      t.boolean :is_published, default: false
      t.references :workshop

      t.timestamps
    end

    add_index :reports, :workshop_id

    add_column :workshop_images, :imageable_type, :string, default: "Workshop"
    rename_column :workshop_images, :workshop_id, :imageable_id
    add_column :workshop_videos, :videoable_type, :string, default: "Workshop"
    rename_column :workshop_videos, :workshop_id, :videoable_id
    add_column :hosts, :hostable_type, :string, default: "Workshop"
    rename_column :hosts, :workshop_id, :hostable_id

    add_index :workshop_images, [:imageable_id, :imageable_type]
    add_index :workshop_videos, [:videoable_id, :videoable_type]
    add_index :hosts, [:hostable_id, :hostable_type]
    add_index :host_images, :host_id
  end

  def down
    drop_table :reports

    remove_column :workshop_images, :imageable_type
    rename_column :workshop_images, :imageable_id, :workshop_id
    remove_column :workshop_videos, :videoable_type
    rename_column :workshop_videos, :videoable_id, :workshop_id
    remove_column :hosts, :hostable_type
    rename_column :hosts, :hostable_id, :workshop_id

    remove_index :host_images, :host_id
  end
end
