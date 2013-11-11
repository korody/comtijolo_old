class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.string :remember_token
      t.string :password_digest
      t.string :reset_token
      t.datetime :reset_token_sent_at
      t.string :slug, index: true

      t.timestamps
    end
  end
end
