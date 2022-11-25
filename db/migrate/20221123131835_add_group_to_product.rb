class AddGroupToProduct < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :group, null: true, foreign_key: true
  end
end
