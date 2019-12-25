class GameOfLife
    @current_state = nil
    @next_state = nil
    @rows = nil
    @cols = nil

    @@LIVE = 1
    @@DEAD = 0
    @@SLEEP_TIME = 0.2

    def initialize(rows=20, cols=20, initial_state_filepath=nil)
        @current_state = initialise_random_state(rows, cols)
        @rows, @cols = rows, cols
    end

    def play!
        LifeRenderer.run(@current_state)
        sleep @@SLEEP_TIME

        while true
            @next_state = get_next_state

            if @next_state == @current_state
                puts "No Further states possible! Game ENDS!"
                break
            end

            @current_state = @next_state
            @next_state = nil

            LifeRenderer.run(@current_state)
            sleep @@SLEEP_TIME
        end
    end

    def get_next_state
        next_state = Marshal.load(Marshal.dump(@current_state))
        @current_state.each_with_index do |row, row_idx|
            row.each_with_index do |col, col_idx|
                cell_next_state = get_next_state_for_cell(row_idx, col_idx)
                if cell_next_state != col
                    next_state[row_idx][col_idx] = cell_next_state
                end
            end
        end

        next_state
    end

    def get_neighbours_for_cell(row, col)
        neighbouring_coords = Array.new()

        ((row-1)..(row+1)).each do |row_idx|
            next if row_idx < 0 || row_idx >= @rows  # Don't go off the edge

            ((col-1)..(col+1)).each do |col_idx|
                next if col_idx < 0 || col_idx >= @cols  # Don't go off the edge
                next if row_idx == row && col_idx == col  # Don't count current cell as the neighbour

                neighbouring_coords.push([row_idx, col_idx])
            end
        end

        neighbouring_coords.map {|coords| @current_state[coords[0]][coords[1]]}
    end

    def get_next_state_for_cell(row, col)
        neighbours = get_neighbours_for_cell(row, col)
        live_count = neighbours.reduce(:+)

        cell_current_state = @current_state[row][col]
        cell_next_state = cell_current_state

        if cell_current_state == @@LIVE
            if live_count <= 1 || live_count > 3
                cell_next_state = @@DEAD
            end
        elsif cell_current_state == @@DEAD
            if live_count == 3
                cell_next_state = @@LIVE
            end
        end

        cell_next_state
    end

    private def initialise_random_state(rows, cols)
        Array.new(rows) {Array.new(cols) {rand(0..1)}}
    end

    attr_accessor :current_state
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

        print "\e[#{life_state.length}A"
    end
end


if __FILE__ == $0
    if ARGV.length == 0
        life = GameOfLife.new()
        life.play!
    elsif ARGV.length == 1
        puts "Starting from the state saved in file #{ARGV[0]}"
        start_state = []
    else
        puts "Sorry, the program can only take, at most, one argument."
    end
end
