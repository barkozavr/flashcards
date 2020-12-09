class AddDelaultToCards < ActiveRecord::Migration[6.0]
  def change
    change_column :cards, :attempt, :integer, default: 0
  end
end
