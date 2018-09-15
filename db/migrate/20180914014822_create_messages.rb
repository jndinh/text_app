class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :user
      t.integer :number
      t.text :text

      t.timestamps
    end
  end
end
