class Pace
  attr_reader :distance
  attr_reader :distance_length
  attr_reader :pace_length
  attr_reader :pace_minutes
  attr_reader :pace_seconds
  attr_reader :time_hours
  attr_reader :time_minutes
  attr_reader :time_seconds

  def initialize(type:, distance: nil, pace_length: nil, distance_length: nil, pace_minutes: nil, pace_seconds: nil, time_hours: nil, time_minutes: nil, time_seconds: nil)
    if type == "pace"
      @distance = distance.to_f
      @pace_length = pace_length
      @distance_length = distance_length
      @time_hours = time_hours.to_i
      @time_minutes = time_minutes.to_i
      @time_seconds = time_seconds.to_i
      calculate_pace
    elsif type == "time"
      @distance = distance.to_f
      @pace_length = pace_length
      @distance_length = distance_length
      @pace_minutes = pace_minutes.to_i
      @pace_seconds = pace_seconds.to_i
      calculate_time
    else
      @pace_length = pace_length
      @distance_length = distance_length
      @pace_minutes = pace_minutes.to_i
      @pace_seconds = pace_seconds.to_i
      @time_hours = time_hours.to_i
      @time_minutes = time_minutes.to_i
      @time_seconds = time_seconds.to_i
      calculate_distance
    end
  end

  def print_run_pace
    "To run #{@distance.to_s} #{@pace_length} in #{time(@time_hours, @time_minutes, @time_seconds)}, you need a pace of #{pace(@pace_minutes, @pace_seconds, @pace_length)}"
  end

  def print_run_time
    "If you run #{@time[:distance]} #{@time[:pace_length]} with a pace of #{pace(@time[:pace], @time[:pace_length])}, you'll finish in #{time(@time)}"
  end

  private

  def calculate_pace
    time_in_seconds = convert_to_seconds(@time_hours, @time_minutes, @time_seconds)
    pace_in_seconds = time_in_seconds/@distance
    @pace_minutes = pace_in_seconds.to_i / 60
    @pace_seconds = pace_in_seconds.to_i % 60
  end

  def calculate_time
    pace_in_seconds = convert_to_seconds(0, @pace_minutes, @pace_seconds)
    time_in_seconds = pace_in_seconds * distance
    @time_hours = time_in_seconds.to_i / 60 / 60
    @time_minutes = time_in_seconds.to_i / 60 - (@time_hours * 60)
    @time_seconds = time_in_seconds.to_i % 60,
  end

  def calculate_distance
    time_in_seconds = convert_to_seconds(@time_hours, @time_minutes, @time_seconds)
    pace_in_seconds = convert_to_seconds(0, @pace_minutes, @pace_seconds)
    (time_in_seconds / pace_in_seconds).round(2)
  end

  def convert_to_seconds(hours, minutes, seconds)
    (hours * 60 * 60) + (minutes * 60) + seconds
  end

  def pace(minutes, seconds, pace_length)
    "#{format('%02d', minutes)}:#{format('%02d', seconds)}/#{pace_length}"
  end

  def time(hours, minutes, seconds)
    "#{hours}:#{format('%02d', minutes)}:#{format('%02d', seconds)}"
  end
end