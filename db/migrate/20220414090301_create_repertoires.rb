class CreateRepertoires < ActiveRecord::Migration[6.0]
  def change
    create_table :repertoires do |t|
      t.string       :name,           null: false
      t.integer      :time,           null: false
      t.text         :recipe,         null: false
      t.text         :comment,        null: false
      t.integer      :category_id,    null: false
      t.references   :user,           type: :bigint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
