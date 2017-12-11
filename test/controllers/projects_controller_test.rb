require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "can see project index" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Crowdfunder"
  end
end
