class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
     t.string "first_name",:limit => 25
       t.string "last_name",:limit => 25
         t.string "email",:null => false
         t.string "pasword",:limit => 40

      t.timestamps
    end
  end

  def down
  	drop_table :users
  end
end
