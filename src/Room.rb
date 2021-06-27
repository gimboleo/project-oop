load "Monster.rb"
load "Item.rb"

class Room
    attr_accessor :content

    @@key_exists = false
    @@door_exists = false

    def initialize
        @content = Room.gen_content
        @desc = Room.gen_description
    end

    def to_s
        return @desc
    end

    private 

    def self.gen_content
        res = [Monster, Potion, Sword, *(Key unless @@key_exists), *(Door unless @@door_exists)].sample.new
        @@key_exists = true if res.is_a?(Key)
        @@door_exists = true if res.is_a?(Door)
        return res
    end

    def self.gen_description
        return ["Room full of odd pillars. Water rushes down from several holes in the ceiling and falls through similar holes in the floor. The floor is damp and looks slippery.", 
                "This small chamber is a bloody mess. The corpse of an another human lies on the floor, his belly carved out. Bloody, froglike footprints track away from the corpse and into the darkness.", 
                "You enter a small room and your steps echo. Looking about, you're uncertain why, but then a wall vanishes and reveals an enormous chamber. It's really dark in here."].sample
    end
end

if __FILE__== $0
    r = room.new
    print r.to_s
end