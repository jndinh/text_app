class ChangeNumberToBeString < ActiveRecord::Migration[5.2]
  def change
    change_column :messages, :number, :string
  end
end
