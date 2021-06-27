load "Room.rb"

class World
    @@height = 10
    @@width = 10

    attr_reader :height, :width

    def initialize
        @rooms = Array.new(@@height){Array.new(@@width)}
        @height = @@height
        @width = @@width
    end

    def gen_room(x, y)
        @rooms[x][y] ||= Room.new
        return @rooms[x][y]
    end
end