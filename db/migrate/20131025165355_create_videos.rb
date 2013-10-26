class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :link
      t.text :note
      t.belongs_to :filmable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
