require_relative "cricket_position_relative"
require_relative "cricket_position_actual"
class CricketPitch
def initialize(centre_x, centre_y, radius)
  @centre_x = centre_x
  @centre_y = centre_y
  @radius = radius
  @actual_positions = []
  @relative_positions = []
  build_relative_pos_table
  calc_actual_positions
end

def build_relative_pos_table
  @positions = [CricketPositionRelative.new("deep cover", 0.99, 265),
                CricketPositionRelative.new("cover", 0.45, 265),
                CricketPositionRelative.new("deep midwicket", 0.99, 95),
                CricketPositionRelative.new("midwicket", 0.45, 95),
                CricketPositionRelative.new("silly mid on", 0.10, 105),
                CricketPositionRelative.new("silly mid off", 0.10, 255),
                CricketPositionRelative.new("cow corner", 0.99, 120),
                CricketPositionRelative.new("long on", 0.99, 160),
                CricketPositionRelative.new("mid on", 0.45, 160),
                CricketPositionRelative.new("long off", 0.99, 200),
                CricketPositionRelative.new("mid off", 0.45, 200),
                CricketPositionRelative.new("deep extra cover", 0.99, 240),
                CricketPositionRelative.new("extra cover", 0.45, 240),
                CricketPositionRelative.new("deep point", 0.99, 290),
                CricketPositionRelative.new("point", 0.45, 290),
                CricketPositionRelative.new("deep backward point", 0.99, 315),
                CricketPositionRelative.new("backward point", 0.45, 315),
                CricketPositionRelative.new("third man", 0.99, 340),
                CricketPositionRelative.new("short third man", 0.45, 340),
                CricketPositionRelative.new("fly slip", 0.45, 350),
                CricketPositionRelative.new("straight hit", 0.99, 180.0),
                CricketPositionRelative.new("deep square leg", 0.99, 80.0),
                CricketPositionRelative.new("square leg", 0.45, 80.0),
                CricketPositionRelative.new("long leg", 0.99, 50.0),
                CricketPositionRelative.new("backward square leg", 0.45, 50.0),
                CricketPositionRelative.new("deep fine leg", 0.99, 35.0),
                CricketPositionRelative.new("short fine leg", 0.45, 35.0),
                CricketPositionRelative.new("long stop", 0.99, 0.0),
                CricketPositionRelative.new("first slip", 0.20, 355),
                CricketPositionRelative.new("second slip", 0.20, 353),
                CricketPositionRelative.new("third slip", 0.20, 351),
                CricketPositionRelative.new("fourth slip", 0.20, 349),
                CricketPositionRelative.new("fifth slip", 0.20, 347),
                CricketPositionRelative.new("gully", 0.20, 342),
                CricketPositionRelative.new("leg gully", 0.20, 18),
                CricketPositionRelative.new("short leg", 0.10, 18),
                CricketPositionRelative.new("silly point", 0.10, 342),
                CricketPositionRelative.new("leg slip", 0.20, 9),
                CricketPositionRelative.new("wicket keeper", 0.15, 0.0)
                ]
end

def calc_actual_positions
  puts ""
  @positions.each do |position|
    position_x = @centre_x + (@radius * position.get_distance) * Math.sin(position.get_bearing * Math::PI / 180)
    position_y = @centre_y + (@radius * position.get_distance) * Math.cos(position.get_bearing * Math::PI / 180)
    position_found = position.get_name
    puts "#{position_x}, #{position_y}, #{position_found}"
    @actual_positions << CricketPositionActual.new(position.get_name, position_x, position_y)
  end
  puts ""
end

def on_pitch(position_x, position_y)
  return (position_x - @centre_x)**2 + (position_y - @centre_y)**2 < @radius**2
end

def on_onside(position_x, position_y, right_hand_bat)
  on_onside = false
  if on_pitch(position_x, position_y) then
    if (right_hand_bat and position_x > @centre_x) or  (!right_hand_bat and position_x < @centre_x) then
      on_onside = true
    end
  end
  return on_onside
end

def get_position(position_x, position_y, right_hand_bat)
  puts "Locating position: #{position_x}, #{position_y}"
  
  position_found = ""
  nearest_position = nil
  nearest_set = false
  nearest = 0.0
  
  @actual_positions.each do |position|
    puts "Considering Position:#{position.inspect} ** #{position.get_name} **"
    distance = position.get_distance_to(position_x, position_y)
    puts "Distance to position: #{distance}"
    if !nearest_set then
      nearest_set = true
      position_found = position.get_name
      nearest = distance
    else
      if distance < nearest
        position_found = position.get_name
        nearest = distance
      end
    end
  end
  return position_found
end

end