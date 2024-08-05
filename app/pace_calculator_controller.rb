# frozen_string_literal: true

class PaceCalculatorController < Sinatra::Base
  VALID_DISTANCES = %w[mi km m 500m 50yd 50m 25yd 25m].freeze

  get "/" do
    erb :pace
  end

  get "/pace" do
    if params[:pace]
      check_pace(params)
    elsif params[:time]
      check_time(params)
    elsif params[:distance]
      check_distance(params)
    end
    erb :pace
  end

  private

  def check_pace(params)
    @error = get_errors("pace", params)
    return if @error

    @pace = Pace.new(type: "pace",
      activity: params[:activity],
      distance: params[:distance],
      pace_length: params[:pace_length],
      distance_length: params[:distance_length],
      time_hours: params[:time_hours],
      time_minutes: params[:time_minutes],
      time_seconds: params[:time_seconds])
  end

  def check_time(params)
    @error = get_errors("time", params)
    return if @error

    @pace = Pace.new(type: "time",
      activity: params[:activity],
      distance: params[:distance],
      pace_length: params[:pace_length],
      distance_length: params[:distance_length],
      pace_minutes: params[:pace_minutes],
      pace_seconds: params[:pace_seconds])
  end

  def check_distance(params)
    @error = get_errors("distance", params)
    return if @error

    @pace = Pace.new(type: "distance",
      activity: params[:activity],
      pace_length: params[:pace_length],
      distance_length: params[:distance_length],
      pace_minutes: params[:pace_minutes],
      pace_seconds: params[:pace_seconds],
      time_hours: params[:time_hours],
      time_minutes: params[:time_minutes],
      time_seconds: params[:time_seconds])
  end

  def get_errors(type, params)
    if validate_distance(params)
      "Please select a valid value for distance and/or pace type."
    elsif type == "pace"
      errors_pace(params)
    elsif type == "distance"
      errors_distance(params)
    else
      errors_time(params)
    end
  end

  def validate_distance(params)
    !VALID_DISTANCES.include?(params[:distance_length]) ||
      !VALID_DISTANCES.include?(params[:pace_length])
  end

  def errors_pace(params)
    if params[:distance].empty? || time_exists(params)
      "If calculating pace, distance and time are required."
    elsif !distance_greater_than_zero(params)
      "Distance must be greater than zero."
    elsif !time_greater_than_zero(params)
      "Time must be greater than zero."
    end
  end

  def errors_distance(params)
    if pace_exists(params) || time_exists(params)
      "If calculating distance, pace and time are required."
    elsif !pace_greater_than_zero(params)
      "Pace must be greater than zero."
    elsif !time_greater_than_zero(params)
      "Time must be greater than zero."
    end
  end

  def errors_time(params)
    if params[:distance].empty? || pace_exists(params)
      "If calculating time, distance and pace are required."
    elsif !distance_greater_than_zero(params)
      "Distance must be greater than zero."
    elsif !pace_greater_than_zero(params)
      "Pace must be greater than zero."
    end
  end

  def pace_exists(params)
    params[:pace_minutes].empty? && params[:pace_seconds].empty?
  end

  def time_exists(params)
    params[:time_hours].empty? &&
      params[:time_minutes].empty? &&
      params[:time_seconds].empty?
  end

  def pace_greater_than_zero(params)
    params[:pace_minutes].to_f.positive? || params[:pace_seconds].to_f.positive?
  end

  def time_greater_than_zero(params)
    params[:time_hours].to_f.positive? ||
      params[:time_minutes].to_f.positive? ||
      params[:time_seconds].to_f.positive?
  end

  def distance_greater_than_zero(params)
    params[:distance].to_f.positive?
  end
end
