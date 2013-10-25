class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.text :note
      t.belongs_to :attachable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
