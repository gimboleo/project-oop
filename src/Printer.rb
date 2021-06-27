class Printer
    def initialize(delay = 0.02) 
        @delay = delay
    end

    def pretty_print(str)
        str.each_char do |c|
            sleep @delay
            print c
        end
        puts
    end

    def loading_animation(s, fps=5)
        chars = ["|", "/", "-" ,"\\"]
        delay = 1.0 / fps

        (s * fps).round.times do |i|
            print chars[i % chars.length]
            sleep delay
            print "\b"
        end
    end
end

if __FILE__== $0
    p = Printer.new
    test1 = "Witaj poszukiwaczu przygód!!!"
    test2 = "UMIEROSZ!!!!!11"

    p.pretty_print(test1)
    p.loading_animation(5)
    p.pretty_print(test2)
end