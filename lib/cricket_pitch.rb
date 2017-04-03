require_relative "cricket_position"

class CricketPitch
  def initialize(centre, radius)
    @centre_point = centre
    @radius = radius
    @positions = []
    build_relative_pos_table
  end

  def build_relative_pos_table
    @positions = [CricketPosition.new("deep cover", PolarCoordinate.new(0.99, 265)),
                CricketPosition.new("cover", PolarCoordinate.new(0.45, 265)),
                CricketPosition.new("deep midwicket", PolarCoordinate.new(0.99, 95)),
                CricketPosition.new("midwicket", PolarCoordinate.new(0.45, 95)),
                CricketPosition.new("silly mid on", PolarCoordinate.new(0.10, 105)),
                CricketPosition.new("silly mid off", PolarCoordinate.new(0.10, 255)),
                CricketPosition.new("cow corner", PolarCoordinate.new(0.99, 120)),
                CricketPosition.new("long on", PolarCoordinate.new(0.99, 160)),
                CricketPosition.new("mid on", PolarCoordinate.new(0.45, 160)),
                CricketPosition.new("long off", PolarCoordinate.new(0.99, 200)),
                CricketPosition.new("mid off", PolarCoordinate.new(0.45, 200)),
                CricketPosition.new("deep extra cover", PolarCoordinate.new(0.99, 240)),
                CricketPosition.new("extra cover", PolarCoordinate.new(0.45, 240)),
                CricketPosition.new("deep point", PolarCoordinate.new(0.99, 290)),
                CricketPosition.new("point", PolarCoordinate.new(0.45, 290)),
                CricketPosition.new("deep backward point", PolarCoordinate.new(0.99, 315)),
                CricketPosition.new("backward point", PolarCoordinate.new(0.45, 315)),
                CricketPosition.new("third man", PolarCoordinate.new(0.99, 340)),
                CricketPosition.new("short third man", PolarCoordinate.new(0.45, 340)),
                CricketPosition.new("fly slip", PolarCoordinate.new(0.45, 350)),
                CricketPosition.new("straight hit", PolarCoordinate.new(0.99, 180.0)),
                CricketPosition.new("deep square leg", PolarCoordinate.new(0.99, 80.0)),
                CricketPosition.new("square leg",PolarCoordinate.new(0.45, 80.0)),
                CricketPosition.new("long leg", PolarCoordinate.new(0.99, 50.0)),
                CricketPosition.new("backward square leg", PolarCoordinate.new(0.45, 50.0)),
                CricketPosition.new("deep fine leg", PolarCoordinate.new(0.99, 35.0)),
                CricketPosition.new("short fine leg", PolarCoordinate.new(0.45, 35.0)),
                CricketPosition.new("long stop", PolarCoordinate.new(0.99, 0.0)),
                CricketPosition.new("first slip", PolarCoordinate.new(0.20, 355)),
                CricketPosition.new("second slip", PolarCoordinate.new(0.20, 353)),
                CricketPosition.new("third slip", PolarCoordinate.new(0.20, 351)),
                CricketPosition.new("fourth slip", PolarCoordinate.new(0.20, 349)),
                CricketPosition.new("fifth slip", PolarCoordinate.new(0.20, 347)),
                CricketPosition.new("gully", PolarCoordinate.new(0.20, 342)),
                CricketPosition.new("leg gully", PolarCoordinate.new(0.20, 18)),
                CricketPosition.new("short leg", PolarCoordinate.new(0.10, 18)),
                CricketPosition.new("silly point", PolarCoordinate.new(0.10, 342)),
                CricketPosition.new("leg slip", PolarCoordinate.new(0.20, 9)),
                CricketPosition.new("wicket keeper", PolarCoordinate.new(0.15, 0.0))
                ]
  end

  def on_pitch(position)
    return (position.get_position_x - @centre_point.get_position_x)**2 + (position.get_position_y - @centre_point.get_position_y)**2 < @radius**2
  end

  def on_onside(position, right_hand_bat)
    on_onside = false
    if on_pitch(position) then
      on_onside = onside(right_hand_bat, position) 
    end
    on_onside
  end

  def get_position(query_position, right_hand_bat)
     
    position_found = ""
    nearest_position = nil
    nearest_set = false
    nearest = 0.0
  
    @positions.each do |position|
      position_name = position.get_name
      position_on_pitch = position.get_position_on_pitch(@centre_point, @radius)
      distance = position_on_pitch.get_distance_to(query_position)
      
      if !nearest_set then
        nearest_set = true
        position_found = position_name
        nearest = distance
      else
        if distance < nearest
          position_found = position_name
          nearest = distance
        end
      end
    end
    position_found
  end
  
  def onside(right_hand_bat, position)
    (right_hand_bat and position.get_position_x > @centre_point.get_position_x) or (!right_hand_bat and position.get_position_x < @centre_point.get_position_x)
  end
  
end