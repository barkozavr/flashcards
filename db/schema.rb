ActiveRecord::Schema.define(version: 20_201_116_182_339) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.text "original_text", null: false
    t.text "translated_text", null: false
    t.date "review_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end
