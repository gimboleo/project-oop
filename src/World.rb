load "Room.rb"

#Represents the game map
class World
    @@height = 10
    @@width = 10

    #Represents dimensions of the map (It's a rectangle)
    attr_reader :height, :width

    def initialize
        @rooms = Array.new(@@height){Array.new(@@width)}
        @height = @@height
        @width = @@width
    end

    #Returns the room located at given coordinates, generates a new one if necessary
    def gen_room(x, y)
        @rooms[x][y] ||= Room.new
        return @rooms[x][y]
    end
end