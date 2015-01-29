class CreateInstructions < ActiveRecord::Migration
  def change
    create_table(:instructions) do |t|
      t.string :description
      t.integer :recipe_id
    end
  end
end
