class CreateCookingHacks < ActiveRecord::Migration[6.0]
  def change
    create_table :cooking_hacks do |t|
      t.string      :title
      t.text        :contents
      t.references  :user

      t.timestamps
    end
  end
end
