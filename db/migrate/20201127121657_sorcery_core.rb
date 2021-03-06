class SorceryCore < ActiveRecord::Migration[6.0]
  def change
      add_column :users, :salt, :string
      rename_column :users, :password, :crypted_password
      add_index :users, :email, unique: true
  end
end
