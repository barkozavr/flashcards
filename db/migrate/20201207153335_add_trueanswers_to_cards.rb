class AddTrueanswersToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :true_answers, :integer, default: 0
  end
end
