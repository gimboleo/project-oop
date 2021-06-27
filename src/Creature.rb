load "Dice.rb"

module Creature
    @@default_values =
    {
        max_hp: 10,
        dice_amount: 1,
        dice_sides: 4
    }

    attr_reader :hp, :ap, :max_hp

    def initialize(max_hp = @@default_values[:max_hp], d_a = @@default_values[:dice_amount], d_s = @@default_values[:dice_sides])
        @max_hp = max_hp
        @hp = max_hp
        @ap = Dice.new(d_a, d_s)
    end

    def alive?
        return @hp > 0
    end

    def dmg(amount)
        @hp -= amount
    end

    def heal(amount)
        @hp = [@hp + amount, @max_hp].min
    end

    def health_status
        val = @hp.to_f / @max_hp.to_f

        if val > 0.75
            return "It looks healthy."
        elsif val > 0.50
            return "It looks hurt."
        elsif val > 0.25
            return "It looks really hurt."
        elsif val > 0
            return "It's barely standing."
        else
            return "It already breathed it's last breath..."
        end
    end
end