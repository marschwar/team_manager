require 'test_helper'

class MemberStatusControllerTest < ActionController::TestCase

  test "guest should be unauthorized" do
    with_user :user

    assert_raises do
      get :index
    end
  end

  test "manager should be unauthorized" do
    with_user :manager

    assert_raises do
      get :index
    end
  end

  test "should get index" do
    with_user :headcoach
    get :index
    assert_response :success
    assert_not_nil assigns(:status)
    assert_not_nil assigns(:latest_import_date)
  end
end
