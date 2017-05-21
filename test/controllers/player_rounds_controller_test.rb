require 'test_helper'

class PlayerRoundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_round = player_rounds(:one)
  end

  test "should get index" do
    get player_rounds_url
    assert_response :success
  end

  test "should get new" do
    get new_player_round_url
    assert_response :success
  end

  test "should create player_round" do
    assert_difference('PlayerRound.count') do
      post player_rounds_url, params: { player_round: { amount: @player_round.amount } }
    end

    assert_redirected_to player_round_url(PlayerRound.last)
  end

  test "should show player_round" do
    get player_round_url(@player_round)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_round_url(@player_round)
    assert_response :success
  end

  test "should update player_round" do
    patch player_round_url(@player_round), params: { player_round: { amount: @player_round.amount } }
    assert_redirected_to player_round_url(@player_round)
  end

  test "should destroy player_round" do
    assert_difference('PlayerRound.count', -1) do
      delete player_round_url(@player_round)
    end

    assert_redirected_to player_rounds_url
  end
end
