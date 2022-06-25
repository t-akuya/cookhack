class CreateLikeHacks < ActiveRecord::Migration[6.0]
  def change
    create_table :like_hacks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cooking_hack, null: false, foreign_key: true

      t.timestamps
    end
  end
end
