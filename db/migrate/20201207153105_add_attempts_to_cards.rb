class AddAttemptsToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :attempt, :integer
  end
end
