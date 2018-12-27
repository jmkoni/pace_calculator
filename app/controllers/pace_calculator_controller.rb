class PaceCalculatorController < ApplicationController
  def index
    render 'pace_calculator/pace'
  end

  def pace
    if params[:pace]
      if params[:distance].empty? || (params[:time_hours].empty? && params[:time_minutes].empty? && params[:time_seconds].empty?)
        @error = "If calculating pace, distance and time are required."
      else
        @pace = Pace.new(type: "pace",
                         activity: params[:activity],
                         distance: params[:distance],
                         pace_length: params[:pace_length],
                         distance_length: params[:distance_length],
                         time_hours: params[:time_hours],
                         time_minutes: params[:time_minutes],
                         time_seconds: params[:time_seconds])
      end
    elsif params[:time]
      if params[:distance].empty? || (params[:pace_minutes].empty? && params[:pace_seconds].empty?)
        @error = "If calculating time, distance and pace are required."
      else
        @pace = Pace.new(type: "time",
                         activity: params[:activity],
                         distance: params[:distance],
                         pace_length: params[:pace_length],
                         distance_length: params[:distance_length],
                         pace_minutes: params[:pace_minutes],
                         pace_seconds: params[:pace_seconds])
      end
    elsif params[:distance]
      if (params[:pace_minutes].empty? && params[:pace_seconds].empty?) || (params[:time_hours].empty? && params[:time_minutes].empty? && params[:time_seconds].empty?)
        @error = "If calculating distance, pace and time are required."
      else
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
    end
    render 'pace_calculator/pace'
  end
end
