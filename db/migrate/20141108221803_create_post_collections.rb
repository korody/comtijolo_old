class CreatePostCollections < ActiveRecord::Migration
  def change
    create_table :post_collections do |t|
      t.belongs_to :post, index: true
      t.belongs_to :collection, index: true

      t.timestamps
    end
  end
end