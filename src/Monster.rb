load "Creature.rb"

class Monster
    include Creature
    @@max_hp = 20

    def initialize
        super(@@max_hp)
    end

    def to_s()
        return "Loathsome humanoid with rubbery skin, hoof-like feet and long claws.\n" + self.health_status
    end
end

if __FILE__== $0
    m = Monster.new
    m.dmg(8)
    puts m.to_s
end