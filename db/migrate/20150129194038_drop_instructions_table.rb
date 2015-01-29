class DropInstructionsTable < ActiveRecord::Migration
  def change
    drop_table :instructions
  end
end
