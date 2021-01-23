module CitiesHelper
  def friendly_time(time)
    time.strftime("%m/%d/%y")
  end

  def aqi_font_color(aqi)
    case aqi
    when 0..50
      "font-light text-green-500"
    when 51.100
      "font-light text-yellow-400"
    when 101..150
      "font-light text-yellow-600"
    when 151..200
      "font-light text-red-500"
    when 201..300
      "font-light text-indigo-600"
    else
      "font-light text-red-900"
    end
  end
end
