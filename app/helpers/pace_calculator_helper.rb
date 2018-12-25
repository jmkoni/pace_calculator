module PaceCalculatorHelper
  def km_to_miles(km)
    km * 0.62137
  end

  def miles_to_km(mi)
    mi / 0.62137
  end

  def convert_to_meters(distance, metric)
    if metric == 'km'
      distance * 1000
    elsif metric == 'mi'
      miles_to_km(distance) * 1000
    else
      distance
    end
  end

  def convert_to_seconds(hours, minutes, seconds)
    (hours * 60 * 60) + (minutes * 60) + seconds
  end


end
