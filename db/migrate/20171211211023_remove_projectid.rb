class RemoveProjectid < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :project_id
  end
end
