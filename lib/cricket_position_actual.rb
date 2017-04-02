class CricketPositionActual

def initialize(name, position_x, position_y)
@name = name
@position_x = position_x
@position_y= position_y
end

def get_name
  return @name
end

def get_position_x
  return @position_x
end

def get_position_y
  return @position_y
end

def get_distance_to(target_x, target_y)
  distance = Math.sqrt((@position_x - target_x)**2 + (@position_y - target_y)**2)
end

end