class RenameProjectsCategories < ActiveRecord::Migration[5.1]
  def change
    rename_table :projects_categories, :categories_projects
  end
end
