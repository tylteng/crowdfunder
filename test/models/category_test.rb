require 'test_helper'

class CategoryTest < ActiveSupport::TestCase


  def test_create_a_category
    category = Category.create
    assert category.persisted?
  end

  def test_category_has_a_name
    category = Category.create(name: "Coding")
    assert_equal("Coding", category.name)
  end

  def test_category_can_update_name
    category = Category.create(name: "Coding")
    category.name = "Programming"
    category.save
    assert_equal("Programming", category.name)
  end

  def test_category_can_be_destroyed
    category = Category.create(name: "Coding")
    category.destroy
    refute category.persisted?
  end

  def test_category_related_to_projects
    category = Category.create
    project = create(:project)
    category.projects << project
    assert_equal(1, category.projects.size)
  end
end
