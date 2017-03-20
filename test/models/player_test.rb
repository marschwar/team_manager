require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test 'finds player with team' do
    expected = [players(:two), players(:one)]
    assert_equal expected, Player.of_team(teams(:one)).to_a
  end

  test 'matches player with first and last name' do
    assert Player.new(last_name: 'Foo', first_name: 'Bar').matches?('FOO', 'BAR', Date.today)
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
end
