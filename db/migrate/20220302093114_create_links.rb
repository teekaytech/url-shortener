class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :original
      t.string :code
      t.integer :clicks

      t.timestamps
    end
    
    add_index :links, :code
  end
end
