class AddIconToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column  :users, :icon, :string
  end
end
