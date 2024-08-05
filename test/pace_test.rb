require "minitest/autorun"
require "./app/pace"
require "./app/converter_service"
class TestPace < Minitest::Test
  def test_calculates_pace_run
    pace = Pace.new(type: "pace", activity: "run", distance: 5, pace_length: "mile", distance_length: "mile", time_hours: 0, time_minutes: 30, time_seconds: 0)
    assert_equal "To run 5.0 mile in 0:30:00, you need a pace of 6:00/mile", pace.print_pace
  end

  def test_calculates_time_run
    pace = Pace.new(type: "time", activity: "run", distance: 5, pace_length: "mile", distance_length: "mile", pace_minutes: 6, pace_seconds: 0)
    assert_equal "If you run 5.0 mile with a pace of 6:00/mile, you'll finish in 0:30:00", pace.print_time
  end

  def test_calculates_distance_run
    pace = Pace.new(type: "distance", activity: "run", pace_length: "mile", distance_length: "mile", pace_minutes: 6, pace_seconds: 0, time_hours: 0, time_minutes: 30, time_seconds: 0)
    assert_equal "If you run a pace of of 6:00/mile for 0:30:00, you will go 5 miles.", pace.print_distance
  end

  def test_calculates_pace_swim
    skip "this has a bug"
    pace = Pace.new(type: "pace", activity: "swim", distance: 500, pace_length: "50yd", distance_length: "meter", time_hours: 0, time_minutes: 10, time_seconds: 0)
    assert_equal "If you swim 500.0 meter with a pace of 2:00/50yd, you'll finish in 0:43:44", pace.print_pace
  end

  def test_calculates_time_swim
    pace = Pace.new(type: "time", activity: "swim", distance: 500, pace_length: "25yd", distance_length: "meter", pace_minutes: 2, pace_seconds: 0)
    assert_equal "If you swim 500.0 meter with a pace of 2:00/25yd, you'll finish in 0:43:44", pace.print_time
  end

  def test_calculates_distance_swim
    skip "this has a bug"
    pace = Pace.new(type: "distance", activity: "swim", pace_length: "50m", distance_length: "meter", pace_minutes: 2, pace_seconds: 0, time_hours: 0, time_minutes: 10, time_seconds: 0)
    assert_equal "If you swim a pace of of 2:00/50m for 0:10:00, you will go 500 meters.", pace.print_distance
  end

  def test_calculates_pace_row
    skip "this has a bug"
    pace = Pace.new(type: "pace", activity: "row", distance: 2000, pace_length: "500m", distance_length: "meter", time_hours: 0, time_minutes: 10, time_seconds: 0)
    assert_equal "To row 2000 m in 0:10:00, you need a pace of 2:30/500m", pace.print_pace
  end

  def test_calculates_time_row
    pace = Pace.new(type: "time", activity: "row", distance: 2, pace_length: "500meter", distance_length: "mile", pace_minutes: 2, pace_seconds: 30)
    assert_equal "If you row 2.0 mile with a pace of 2:30/500meter, you'll finish in 0:08:02", pace.print_time
  end

  def test_calculates_distance_row
    pace = Pace.new(type: "distance", activity: "row", pace_length: "500meter", distance_length: "mile", pace_minutes: 2, pace_seconds: 30, time_hours: 0, time_minutes: 10, time_seconds: 0)
    assert_equal "If you row a pace of of 2:30/500meter for 0:10:00, you will go 6.44 miles.", pace.print_distance
  end
end
