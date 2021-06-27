#load "Player.rb"
#load "Printer.rb"

module Item
    @@default_values =
    {
        name: "Unidentified item",
        desc: "An item. You have no idea what it does."
    }

    attr_accessor :name, :description

    def initialize(name = @@default_values[:name], desc = @@default_values[:desc])
        @name = name
        @description = desc
    end

    def interact(player)
        player.add_to_inv(self)
        return "You pick up #{@name}."
    end

    def use_item(player, index = -1)
        return "Seems like nothing happened. Huh."
    end

    def to_s
        return @name + "\n" + @description
    end
end



class Potion
    include Item

    def initialize
        super("Potion", "Heals 10 HP.")
    end

    def use_item(player, index = -1)
        player.heal(10)
        player.remove_from_inv(index)
        return "You consumed the potion. Your wounds start to heal!"
    end
end

class Sword
    include Item

    def initialize
        super("Sword", "Slightly better than your current one.")
    end

    def use_item(player, index = -1)
        player.ap.bonus += 1
        player.remove_from_inv(index)
        return "You equipped the better sword. Your AP increased by 1!"
    end
end

class Key
    include Item

    def initialize
        super("Key", "Probably fits into a door.")
    end

    def use_item(player, index = -1)
        return "Interact with the door while having a key in your inventory to open it."
    end
end

class Door 
    include Item
    
    def initialize
        super("Door", "Your way outta here!")
    end

    def has_key?(player)
        return player.inv.any? {|item| item.is_a?(Key)}
    end

    def interact(player)
        return true, "You managed to open the door!" if has_key?(player)
        return false, "You need to find the key first!"
    end

    def use_item(player, index = -1)
        return "Not sure how you managed to pick up a door. Congratulations I guess."
    end
end