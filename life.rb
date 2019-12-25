class GameOfLife
    @current_state = nil

    def initialize(rows=20, cols=20, initial_state_filepath=nil)
        @current_state = initialise_random_state(rows, cols)
    end

    def play!
        LifeRenderer.run(@current_state)
    end

    private def initialise_random_state(rows, cols)
        Array.new(rows) {Array.new(cols) {rand(0..1)}}
    end

    attr_reader :current_state
end

class LifeRenderer
    @@cell_to_char_map = {
        0 => ".",
        1 => "#"
    }

    def self.run(life_state)
        life_state.each do |row|
            row.each do |cell|
                print " #{@@cell_to_char_map[cell]} "
            end
            puts
        end
    end
end



if ARGV.length == 0
    life = GameOfLife.new()
    life.play!
elsif ARGV.length == 1
    puts "Starting from the state saved in file #{ARGV[0]}"
    start_state = []
else
    puts "Sorry, the program can only take, at most, one argument."
end
