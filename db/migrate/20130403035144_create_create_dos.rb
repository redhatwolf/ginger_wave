class CreateCreateDos < ActiveRecord::Migration
  def change
    create_table :create_dos do |t|
      t.integer :num
      t.string :carrier
      t.string :warehouse

      t.timestamps
    end
  end
end
