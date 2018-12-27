# frozen_string_literal: true

class ConverterService
  def self.convert_to_seconds(hours, minutes, seconds)
    (hours * 60 * 60) + (minutes * 60) + seconds
  end

  def self.convert_length(distance, current_length, length_to_convert_to)
    if current_length == length_to_convert_to
      distance
    elsif (current_length == '500m') || (length_to_convert_to == '500m')
      convert_length_row(distance, current_length, length_to_convert_to)
    elsif !(%w[50yd 50m 25yd 25m] & [current_length, length_to_convert_to]).empty?
      convert_length_swim(distance, current_length, length_to_convert_to)
    else
      convert_length_run(distance, current_length, length_to_convert_to)
    end
  end

  def self.convert_length_run(distance, current_length, length_to_convert_to)
    if current_length == 'm'
      distance /= 1000
      if length_to_convert_to == 'km'
        distance
      else
        km_to_miles(distance)
      end
    elsif current_length == 'km'
      km_to_miles(distance)
    else
      miles_to_km(distance)
    end
  end

  def self.convert_length_row(distance, current_length, length_to_convert_to)
    if current_length == '500m'
      convert_from_meter(length_to_convert_to, distance, 500)
    elsif length_to_convert_to == '500m'
      convert_to_meter(current_length, distance, 500)
    end
  end

  def self.convert_length_swim(distance, current_length, length_to_convert_to)
    if current_length.include?('yd')
      current_length = current_length.delete('^0-9').to_i
      convert_from_yard(length_to_convert_to, distance, current_length)
    elsif length_to_convert_to.include?('yd')
      length_to_convert_to = length_to_convert_to.delete('^0-9').to_i
      convert_to_yard(current_length, distance, length_to_convert_to)
    elsif current_length.include?('m')
      current_length = current_length.delete('^0-9').to_i
      convert_from_meter(length_to_convert_to, distance, current_length)
    elsif length_to_convert_to.include?('m')
      length_to_convert_to = length_to_convert_to.delete('^0-9').to_i
      convert_to_meter(current_length, distance, length_to_convert_to)
    end
  end

  def self.convert_from_meter(length_to_convert_to, distance, lap_length)
    distance *= lap_length
    if length_to_convert_to == 'm'
      distance
    elsif length_to_convert_to == 'km'
      distance / 1000
    else
      km_to_miles(distance / 1000)
    end
  end

  def self.convert_to_meter(current_length, distance, lap_length)
    if current_length == 'm'
      distance / lap_length
    elsif current_length == 'km'
      (distance * 1000) / lap_length
    else
      (miles_to_km(distance) * 1000) / lap_length
    end
  end

  def self.convert_from_yard(length_to_convert_to, distance, lap_length)
    distance = yards_to_miles(distance * lap_length)
    if length_to_convert_to == 'mi'
      distance
    elsif length_to_convert_to == 'km'
      miles_to_km(distance)
    else
      miles_to_km(distance) * 1000
    end
  end

  def self.convert_to_yard(current_length, distance, lap_length)
    if current_length == 'mi'
      miles_to_yards(distance) / lap_length
    elsif current_length == 'km'
      miles_to_yards(km_to_miles(distance)) / lap_length
    else
      miles_to_yards(km_to_miles(distance / 1000)) / lap_length
    end
  end

  def self.km_to_miles(kilometers)
    kilometers * 0.62137
  end

  def self.miles_to_km(miles)
    miles / 0.62137
  end

  def self.yards_to_miles(yards)
    yards / 1760
  end

  def self.miles_to_yards(miles)
    miles * 1760
  end

  def self.convert_to_meters(distance, metric)
    if metric == 'km'
      distance * 1000
    elsif metric == 'mi'
      miles_to_km(distance) * 1000
    else
      distance
    end
  end
end
