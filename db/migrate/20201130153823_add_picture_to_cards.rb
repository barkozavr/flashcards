class AddPictureToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :picture, :string
  end
end
