#Represents a dice roll in standard rpg n*k+m format, where n is a number of dice, k is number of sides and m is an additional bonus
class Dice
    #Represents one of the three numbers in the n*k+m format
    attr_accessor :amount, :die, :bonus

    def initialize(amount = 1, die = 6, bonus = 0)
        @amount = amount
        @die = die 
        @bonus = bonus
    end

    #Rolls the given dice combination
    def roll
        #str = @amount.times.collect {(rand(@die) + 1).to_s + "+"}.inject(:+).delete_suffix("+")
        return @amount.times.collect {rand(@die) + 1}.inject(:+)
    end

    #Returns a string representation of given dice combination
    def to_s
        str = "#{@amount}d#{@die}"
        str += "+#{@bonus}" unless @bonus == 0
        return str
    end

end

if __FILE__== $0
    d = Dice.new(3, 6, 2)
    puts d.roll
    puts d.to_s
end