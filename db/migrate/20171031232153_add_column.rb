class AddColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :sub_id, :integer, null: false, default: 1
    add_index :posts, :sub_id
  end
end
