class RemoveUserIdFromCards < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cards, :user
  end
end
