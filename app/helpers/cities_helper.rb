module CitiesHelper
  def friendly_time(time)
    time.strftime("%B %e, %Y")
  end

  def aqi_font_color(aqi)
    case aqi
    when 0..50
      "font-bold text-green-500"
    when 51.100
      "font-bold text-yellow-400"
    when 101..150
      "font-bold text-yellow-600"
    when 151..200
      "font-bold text-red-500"
    when 201..300
      "font-bold text-indigo-600"
    else
      "font-bold text-red-900"
    end
  end
end
