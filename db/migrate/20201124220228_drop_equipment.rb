class DropEquipment < ActiveRecord::Migration[5.2]
  def change
    drop_table :equipment
  end
end
