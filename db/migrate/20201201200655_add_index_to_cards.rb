class AddIndexToCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :deck, null: false, foreign_key: true
  end
end
