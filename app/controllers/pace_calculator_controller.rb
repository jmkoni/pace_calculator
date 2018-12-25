class PaceCalculatorController < ApplicationController
  def index
    render 'pace_calculator/run'
  end

  def run
    if params[:pace]
      @pace = Pace.new(type: "pace",
                       distance: params[:distance],
                       pace_length: params[:pace_length],
                       distance_length: params[:distance_length],
                       time_hours: params[:time_hours],
                       time_minutes: params[:time_minutes],
                       time_seconds: params[:time_seconds])
    elsif params[:time]
      @pace = Pace.new(type: "time",
                       distance: params[:distance],
                       pace_length: params[:pace_length],
                       distance_length: params[:distance_length],
                       pace_minutes: params[:pace_minutes],
                       pace_seconds: params[:pace_seconds])
    elsif params[:distance]
      @pace = Pace.new(type: "distance",
                       pace_length: params[:pace_length],
                       distance_length: params[:distance_length],
                       pace_minutes: params[:pace_minutes],
                       pace_seconds: params[:pace_seconds],
                       time_hours: params[:time_hours],
                       time_minutes: params[:time_minutes],
                       time_seconds: params[:time_seconds])
    end
  end

  def row

  end

  def swim
  end


end
