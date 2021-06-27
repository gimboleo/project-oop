#Template for items found in the world
module Item
    @@default_values =
    {
        name: "Unidentified item",
        desc: "An item. You have no idea what it does."
    }

    def initialize(name = @@default_values[:name], desc = @@default_values[:desc])
        @name = name
        @description = desc
    end

    #Defines behaviour when player interacts with the item
    def interact(player)
        player.add_to_inv(self)
        return "You pick up #{@name}."
    end

    #Defines behaviour when player uses the item
    def use_item(player, index = -1)
        return "Seems like nothing happened. Huh."
    end

    #Returns a string with the item's description
    def to_s
        return @name + "\n" + @description
    end
end


#An item that heals the player
class Potion
    include Item

    def initialize
        super("Potion", "Heals 10 HP.")
    end

    #The potion heals the player and disappears upon use
    def use_item(player, index = -1)
        player.heal(10)
        player.remove_from_inv(index)
        return "You consumed the potion. Your wounds start to heal!"
    end
end

#An item that makes the player stronger
class Sword
    include Item

    def initialize
        super("Sword", "Slightly better than your current one.")
    end

    #The sword increases player's damage bonus and disappears upon use
    def use_item(player, index = -1)
        player.ap.bonus += 1
        player.remove_from_inv(index)
        return "You equipped the better sword. Your AP increased by 1!"
    end
end

#An item that is needed to open the door
class Key
    include Item

    def initialize
        super("Key", "Probably fits into a door.")
    end

    #The key doesn't do anything upon use
    def use_item(player, index = -1)
        return "Interact with the door while having a key in your inventory to open it."
    end
end

#An item that cannot be picked up, opening it using the key ends the game
class Door 
    include Item
    
    def initialize
        super("Door", "Your way outta here!")
    end

    #The door opens if player picked up the key
    def interact(player)
        return true, "You managed to open the door!" if has_key?(player)
        return false, "You need to find the key first!"
    end

    #Using the door doesn't do anything as this item cannot be picked up
    def use_item(player, index = -1)
        return "Not sure how you managed to pick up a door. Congratulations I guess."
    end

    private

    #Checks if player has the key in his inventory
    def has_key?(player)
        return player.inv.any? {|item| item.is_a?(Key)}
    end
end