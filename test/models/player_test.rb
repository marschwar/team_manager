require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test 'finds player with team' do
    expected = [players(:two), players(:one)]
    assert_equal expected, Player.of_team(teams(:one)).to_a
  end
end
