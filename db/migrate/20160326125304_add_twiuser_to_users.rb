class AddTwiuserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twiuser, :string, default: ""
  end
end
