# frozen_string_literal: true

class PaceCalculatorController < ApplicationController
  def index
    render 'pace_calculator/pace'
  end

  def pace
    if params[:pace]
      check_pace(params)
    elsif params[:time]
      check_time(params)
    elsif params[:distance]
      check_distance(params)
    end
    render 'pace_calculator/pace'
  end

  private

  def check_pace(params)
    if params[:distance].empty? || time_exists(params)
      @error = 'If calculating pace, distance and time are required.'
    else
      @pace = Pace.new(type: 'pace',
                       activity: params[:activity],
                       distance: params[:distance],
                       pace_length: params[:pace_length],
                       distance_length: params[:distance_length],
                       time_hours: params[:time_hours],
                       time_minutes: params[:time_minutes],
                       time_seconds: params[:time_seconds])
    end
  end

  def check_time(params)
    if params[:distance].empty? || pace_exists(params)
      @error = 'If calculating time, distance and pace are required.'
    else
      @pace = Pace.new(type: 'time',
                       activity: params[:activity],
                       distance: params[:distance],
                       pace_length: params[:pace_length],
                       distance_length: params[:distance_length],
                       pace_minutes: params[:pace_minutes],
                       pace_seconds: params[:pace_seconds])
    end
  end

  def check_distance(params)
    if pace_exists(params) || time_exists(params)
      @error = 'If calculating distance, pace and time are required.'
    else
      @pace = Pace.new(type: 'distance',
                       activity: params[:activity],
                       pace_length: params[:pace_length],
                       distance_length: params[:distance_length],
                       pace_minutes: params[:pace_minutes],
                       pace_seconds: params[:pace_seconds],
                       time_hours: params[:time_hours],
                       time_minutes: params[:time_minutes],
                       time_seconds: params[:time_seconds])
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
end
