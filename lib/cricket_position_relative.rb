class CricketPositionRelative

def initialize(name, distance, bearing_degs)
@name = name
@distance = distance
@bearing_degs= bearing_degs
end

def get_name
  return @name
end

def get_distance
  return @distance
end

def get_bearing
  return @bearing_degs
end

end