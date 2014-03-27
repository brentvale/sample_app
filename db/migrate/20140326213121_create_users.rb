class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	#create_table is a rails method to create a table in the database
    	#for storing users.  Create_table accepts a block with one block variable
    	#in this case called t (for table). inside the block, create_table uses the "t"
    	#object to create name and email columns in the database, both of type string
      t.string :name
      t.string :email

      t.timestamps
      #t.timestamps is a special command that creates two "magic columns"
      #called created_at and updated_at which are timestamps that automaticaly
      #record when a given user is created and updated. 
    end
  end
end
