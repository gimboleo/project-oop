class Dice
    attr_accessor :amount, :die, :bonus

    def initialize(amount = 1, die = 6, bonus = 0)
        @amount = amount
        @die = die 
        @bonus = bonus
    end

    def roll
        #str = @amount.times.collect {(rand(@die) + 1).to_s + "+"}.inject(:+).delete_suffix("+")
        return @amount.times.collect {rand(@die) + 1}.inject(:+)
    end

    def to_s
        str = "#{@amount}k#{@die}"
        str += "+#{@bonus}" unless @bonus == 0
        return str
    end

end

if __FILE__== $0
    d = Dice.new(3, 6, 2)
    puts d.roll
    puts d.to_s
end