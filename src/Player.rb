load "Creature.rb"
load "Item.rb"

class Player
    include Creature
    @@max_hp = 100
    @@dice_amount = 1
    @@dice_sides = 6

    attr_accessor :x_coord, :y_coord
    attr_reader :inv

    def initialize
        super(@@max_hp, @@dice_amount, @@dice_sides)
        @inv = []
        @x_coord = 0
        @y_coord = 0
    end

    def add_to_inv(item)
        @inv.push(item)
    end

    def remove_from_inv(index)
        return if index < 0
        @inv.delete_at(index)
    end

    def to_s
        return "Despite everything, it's still you.\n\n" +

        "*" * 20 + "\n" +
        "HP: #{@hp} / #{@@max_hp}\n" +
        "AP: #{@ap}\n\n" +

        self.inv_to_str + 
        "*" * 20
    end

    private

    def inv_to_str
        res = "Inventory:\n"
        @inv.each_with_index {|x, i| res+= "#{i}. #{(x.respond_to?(:name) && x.name || x)}\n"}
        return res
    end
end

if __FILE__== $0
    p = Player.new
    p.dmg(16)
    p.add_to_inv(Sword.new)
    p.add_to_inv("Test")
    puts p.to_s
    p.remove_from_inv(1)
    puts p.to_s
end