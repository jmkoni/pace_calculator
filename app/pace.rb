# frozen_string_literal: true

class Pace
  attr_reader :type
  attr_reader :activity
  attr_reader :distance
  attr_reader :distance_length
  attr_reader :pace_length
  attr_reader :pace_minutes
  attr_reader :pace_seconds
  attr_reader :time_hours
  attr_reader :time_minutes
  attr_reader :time_seconds

  def initialize(type:, activity:, distance: nil, pace_length: nil,
    distance_length: nil, pace_minutes: nil, pace_seconds: nil,
    time_hours: nil, time_minutes: nil, time_seconds: nil)
    @type = type
    @activity = activity
    @distance = distance.to_f
    @pace_minutes = pace_minutes.to_i
    @pace_seconds = pace_seconds.to_i
    @pace_length = pace_length
    @distance_length = distance_length
    @time_hours = time_hours.to_i
    @time_minutes = time_minutes.to_i
    @time_seconds = time_seconds.to_i
    if type == "pace"
      calculate_pace
    elsif type == "time"
      calculate_time
    else
      calculate_distance
    end
  end

  def print_pace
    "To #{@activity} #{@distance} #{@pace_length} in " \
      "#{time(@time_hours, @time_minutes, @time_seconds)}, " \
      "you need a pace of #{pace(@pace_minutes, @pace_seconds, @pace_length)}"
  end

  def print_time
    "If you #{@activity} #{@distance} #{@distance_length} with " \
      "a pace of #{pace(@pace_minutes, @pace_seconds, @pace_length)}, " \
      "you'll finish in #{time(@time_hours, @time_minutes, @time_seconds)}"
  end

  def print_distance
    "If you #{activity} a pace of of " \
      "#{pace(@pace_minutes, @pace_seconds, @pace_length)}" \
      " for #{time(@time_hours, @time_minutes, @time_seconds)}, " \
      "you will go #{@distance} #{@distance_length}."
  end

  private

  def calculate_pace
    distance_in_pace_length = ConverterService.convert_length(@distance,
      @distance_length,
      @pace_length)
    time_in_seconds = ConverterService.convert_to_seconds(@time_hours,
      @time_minutes,
      @time_seconds)
    pace_in_seconds = time_in_seconds / distance_in_pace_length
    @pace_minutes = pace_in_seconds.to_i / 60
    @pace_seconds = pace_in_seconds.to_i % 60
  end

  def calculate_time
    pace_in_seconds = ConverterService.convert_to_seconds(0,
      @pace_minutes,
      @pace_seconds)
    distance_in_pace_length = ConverterService.convert_length(@distance,
      @distance_length,
      @pace_length)
    time_in_seconds = pace_in_seconds * distance_in_pace_length
    @time_hours = time_in_seconds.to_i / 60 / 60
    @time_minutes = time_in_seconds.to_i / 60 - (@time_hours * 60)
    @time_seconds = time_in_seconds.to_i % 60
  end

  def calculate_distance
    time_in_seconds = ConverterService.convert_to_seconds(@time_hours,
      @time_minutes,
      @time_seconds)
    pace_in_seconds = ConverterService.convert_to_seconds(0,
      @pace_minutes,
      @pace_seconds)
    distance_unconverted = (time_in_seconds / pace_in_seconds)
    @distance = ConverterService.convert_length(distance_unconverted,
      @pace_length,
      @distance_length).round(2)
  end

  def pace(minutes, seconds, pace_length)
    "#{minutes}:#{format("%02d", seconds)}/#{pace_length}"
  end

  def time(hours, minutes, seconds)
    "#{hours}:#{format("%02d", minutes)}:#{format("%02d", seconds)}"
  end
end
