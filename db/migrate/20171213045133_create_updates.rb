class CreateUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :updates do |t|
      t.integer :project_id
      t.text :description

      t.timestamps
    end
  end
end
