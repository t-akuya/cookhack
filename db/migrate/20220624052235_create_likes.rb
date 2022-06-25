class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :repertoire

      t.timestamps
    end
  end
end
