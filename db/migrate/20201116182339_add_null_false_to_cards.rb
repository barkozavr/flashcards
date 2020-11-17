class AddNullFalseToCards < ActiveRecord::Migration[6.0]
  def change
    change_column_null :cards, :original_text, false
    change_column_null :cards, :review_date, false
    change_column_null :cards, :translated_text, false
  end
end
