class AddImages < ActiveRecord::Migration
  def change
    create_table :workshop_videos do |t|
      t.string :link, null: false
      t.references :workshop, null: false

      t.timestamps
    end

    create_table :workshop_images do |t|
      t.string :image, null: false
      t.references :workshop

      t.timestamps
    end

    create_table :host_images do |t|
      t.string :image, null: false
      t.references :host

      t.timestamps
    end
  end
end
