load "Player.rb"
load "World.rb"
load "Printer.rb"

class Game
    def initialize
        @player = Player.new
        @world = World.new
        @printer = Printer.new
        gen_curr_room
    end

    def play
        @printer.loading_animation(5)
        @printer.pretty_print("You woke up in the middle of a dingy, dark room. You have no idea where you are or who you are. A simple wooden sword lies beside you. You pick it up and start your adventure!")
        handle_room
        while true
            process_input(take_input)
        end
    end

    private

    def available_moves
        res = "Available moves:"
        res += " north" if @player.y_coord > 0
        res += " south" if @player.y_coord < @world.height - 1
        res += " west" if @player.x_coord > 0
        res += " east" if @player.x_coord < @world.width - 1
    end

    def gen_curr_room
        @curr_room = @world.gen_room(@player.x_coord, @player.y_coord)
    end

    def handle_room
        @printer.pretty_print(@curr_room.to_s)
        combat(@curr_room.content) if @curr_room.content.is_a?(Monster) and @curr_room.content.alive?
    end

    def combat(c)
        @printer.pretty_print("Sudennly a monster attacks you!")
        
        while @player.alive?
            roll = @player.ap.roll
            c.dmg(roll)
            @printer.pretty_print("You hit the creature, dealing #{roll} damage." + "\n" + c.health_status)
            break unless c.alive?
            roll = c.ap.roll
            @player.dmg(roll)
            @printer.pretty_print("The creature attacks, dealing #{roll} damage. You have #{@player.hp} HP.")
        end

        if @player.alive?
            @printer.pretty_print("You stand victorious!")
        else
            @printer.pretty_print("You have been slain! Your adventure ends here...")
            quit 0
        end
    end

    def take_input
        return gets.strip.split(" ")
    end

    def process_input(s)
        case s[0]
        when "help"
            @printer.pretty_print(File.read("help.desc"))
        when "move"
            case s[1]
            when "north"
                if @player.y_coord > 0
                    @player.y_coord -= 1
                    gen_curr_room
                    handle_room
                else
                    @printer.pretty_print(available_moves)
                end
            when "south"
                if @player.y_coord < @world.height - 1
                    @player.y_coord += 1
                    gen_curr_room
                    handle_room
                else
                    @printer.pretty_print(available_moves)
                end
            when "west"
                if @player.x_coord > 0
                    @player.x_coord -= 1
                    gen_curr_room
                    handle_room
                else
                    @printer.pretty_print(available_moves)
                end
            when "east"
                if @player.x_coord < @world.width - 1
                    @player.x_coord += 1
                    gen_curr_room
                    handle_room
                else
                    @printer.pretty_print(available_moves)
                end
            else
                @printer.pretty_print(available_moves)
            end
        when "status"
            @printer.pretty_print(@player.to_s)
        when "inspect"
            @printer.pretty_print((@curr_room.content && @curr_room.content.to_s) || "You found nothing of interest.")
        when "interact"
            if @curr_room.content.is_a?(Door)
                aux = @curr_room.content.interact(@player)
                @printer.pretty_print(aux[1])
                if aux[0]
                    @printer.pretty_print("You have won, congratulations!")
                    exit 0
                end
            elsif @curr_room.content.respond_to?(:interact)
                @printer.pretty_print(@curr_room.content.interact(@player))
                @curr_room.content = nil
            else @printer.pretty_print("There's nothing to interact with.")
            end
        when "use"
            aux = Integer(s[1]) rescue nil
            if aux && aux >= 0 && aux < @player.inv.length
                @printer.pretty_print((@player.inv[aux].respond_to?(:use_item) && @player.inv[aux].use_item(@player, aux)) || "This item seems unusable.")
            else
                @printer.pretty_print("Invalid inventory index.")
            end
        when "quit"
            exit 0
        end
    end
end

if __FILE__== $0
    g = Game.new
    g.play
end