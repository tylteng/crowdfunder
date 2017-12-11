class ProjectsCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :projects_categories do |t|
      t.integer :project_id, null: false
      t.integer :category_id, null:false
    end
  end
end
