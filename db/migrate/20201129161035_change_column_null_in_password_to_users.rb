class ChangeColumnNullInPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :crypted_password, true
  end
end
