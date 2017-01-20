require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test 'finds player with team' do
    player = Player.create! name: 'foo', team: teams(:one)
    assert_equal [player], Player.for_team(teams(:one))
  end
end
