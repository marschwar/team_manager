require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test 'finds player with team' do
    expected = [players(:two), players(:one)].to_set
    assert_equal expected, Player.of_team(teams(:one)).to_set
  end

  test 'matches player with first and last name' do
    assert Player.new(last_name: 'Foo', first_name: 'Bar').matches?('FOO', 'BAR', Date.today)
  end

  test 'matches player with first and last name with whitespace' do
    assert Player.new(last_name: 'Foo ', first_name: ' Bar').matches?('FOO', 'BAR', Date.today)
  end

  test 'matches player with all' do
    assert Player.new(last_name: 'Foo', first_name: 'Bar', birthday: Date.today).matches?('FOO', 'BAR', Date.today)
  end

  test 'matches player with first name and birthday' do
    assert Player.new(last_name: 'Boo', first_name: 'Bar', birthday: Date.today).matches?('FOO', 'BAR', Date.today)
  end

  test 'matches player with last name and birthday' do
    assert Player.new(last_name: 'Foo', first_name: 'Far', birthday: Date.today).matches?('FOO', 'BAR', Date.today)
  end

  test 'does not match player with birthday only' do
    assert !Player.new(last_name: 'Boo', first_name: 'Far', birthday: Date.today).matches?('FOO', 'BAR', Date.today)
  end

  test 'does not match player without name' do
    assert !Player.new(birthday: Date.today).matches?(nil, nil, Date.today)
  end

  test 'does not match player with same first name only' do
    assert !Player.new(last_name: 'foo', first_name: 'bar', birthday: Date.today).matches?('fofo', 'Bar', Date.today - 1)
  end

  test 'player has number' do
    GameJersey.create!(number: 99, team: teams(:one))
    assert_equal 99, players(:one).actual_number
  end

  test 'player has number not with team' do
    GameJersey.create!(number: 99, team: teams(:two))
    assert_nil players(:one).actual_number
  end

  test 'player has no number' do
    assert_nil players(:three).actual_number
  end
end
