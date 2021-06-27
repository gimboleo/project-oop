load "Monster.rb"
load "Item.rb"

#Represents a single room
class Room
    #Holds an item / a monster
    attr_accessor :content

    @@key_exists = false
    @@door_exists = false

    def initialize
        @content = Room.gen_content
        @desc = Room.gen_description
    end

    #Returns room description
    def to_s
        return @desc
    end

    private 

    #Generates random content of the room
    def self.gen_content
        res = [Monster, Potion, Sword, *(Key unless @@key_exists), *(Door unless @@door_exists)].sample.new
        @@key_exists = true if res.is_a?(Key)
        @@door_exists = true if res.is_a?(Door)
        return res
    end

    #Generates random description of the room
    def self.gen_description
        return File.readlines("room.desc").sample.strip
    end
end

if __FILE__== $0
    r = room.new
    print r.to_s
end