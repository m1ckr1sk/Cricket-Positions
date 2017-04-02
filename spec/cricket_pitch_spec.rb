require_relative '..\lib\cricket_pitch'

describe 'cricket_pitch' do
it 'should return true when a position is on the pitch' do
  #arrange
  pitch = CricketPitch.new(0,0,100)
  
  #act
  on_pitch = pitch.on_pitch(10,10)
  
  #assert
  expect(on_pitch).to be_truthy
end

it 'should return false when a position is not on the pitch' do
  #arrange
  pitch = CricketPitch.new(0,0,100)
  
  #act
  on_pitch = pitch.on_pitch(-100,101)
  
  #assert
  expect(on_pitch).to be_falsey
end

it 'identify the on side for a right hand batsman' do
  #arrange
  pitch = CricketPitch.new(0,0,100)
  
  #act
  on_onside = pitch.on_onside(50,0, true)
  
  #assert
  expect(on_onside).to be_truthy
end

it 'identify the on side for a left hand batsman' do
  #arrange
  pitch = CricketPitch.new(0,0,100)
  
  #act
  on_onside = pitch.on_onside(-50,0, false)
  
  #assert
  expect(on_onside).to be_truthy
end

it 'identify the deep cover for a right hand batsman' do
  #arrange
  radius = 100
  centre_x = 0
  centre_y = 0
  pitch = CricketPitch.new(centre_x,centre_y,radius)
  
  #act
  #deep cover 99% toward boundary 275 degrees around the pitch
  position_x = -99
  position_y = -10
  
  position = pitch.get_position(position_x,position_y, false)
  
  #assert
  expect(position).to eq("deep cover")
end

it 'identify the wicket keeper for a right hand batsman' do
  #arrange
  radius = 100
  centre_x = 0
  centre_y = 0
  pitch = CricketPitch.new(centre_x,centre_y,radius)
  
  #act
  #deep cover 99% toward boundary 275 degrees around the pitch
  position_x = 0
  position_y = 15
  
  position = pitch.get_position(position_x,position_y, false)
  
  #assert
  expect(position).to eq("wicket keeper")
end
end