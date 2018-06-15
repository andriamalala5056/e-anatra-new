require 'test_helper'

class VaguesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vague = vagues(:one)
  end

  test "should get index" do
    get vagues_url
    assert_response :success
  end

  test "should get new" do
    get new_vague_url
    assert_response :success
  end

  test "should create vague" do
    assert_difference('Vague.count') do
      post vagues_url, params: { vague: { rentree: @vague.rentree, status: @vague.status } }
    end

    assert_redirected_to vague_url(Vague.last)
  end

  test "should show vague" do
    get vague_url(@vague)
    assert_response :success
  end

  test "should get edit" do
    get edit_vague_url(@vague)
    assert_response :success
  end

  test "should update vague" do
    patch vague_url(@vague), params: { vague: { rentree: @vague.rentree, status: @vague.status } }
    assert_redirected_to vague_url(@vague)
  end

  test "should destroy vague" do
    assert_difference('Vague.count', -1) do
      delete vague_url(@vague)
    end

    assert_redirected_to vagues_url
  end
end
