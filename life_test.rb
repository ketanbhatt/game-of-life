require "test/unit"
require_relative "./life"


class GameOfLifeTest < Test::Unit::TestCase
    def test_random_state_generated_on_init_with_rows_cols
        rows, cols = 2, 4
        life = GameOfLife.new(rows, cols)

        assert_not_nil life.current_state
        assert_equal life.current_state.length, rows
        assert_equal life.current_state.first.length, cols
    end

    def test_get_neighbours_for_cell
        test_state = [
            [0, 1, 0, 1],
            [0, 1, 1, 1],
            [0, 0, 0, 0]
        ]

        rows, cols = 3, 4
        life = GameOfLife.new(rows, cols)
        life.current_state = test_state

        # Test for middle position
        neighbours = life.get_neighbours_for_cell(1, 2)
        assert_equal neighbours.sort, [0, 0, 0, 0, 1, 1, 1, 1]

        # Test for top left corner
        neighbours = life.get_neighbours_for_cell(0, 0)
        assert_equal neighbours.sort, [0, 1, 1]
        # Test for top right corner
        neighbours = life.get_neighbours_for_cell(0, 3)
        assert_equal neighbours.sort, [0, 1, 1]
        # Test for bottom left corner
        neighbours = life.get_neighbours_for_cell(2, 0)
        assert_equal neighbours.sort, [0, 0, 1]
        # Test for bottom right corner
        neighbours = life.get_neighbours_for_cell(2, 3)
        assert_equal neighbours.sort, [0, 1, 1]

        # Test for top edge
        neighbours = life.get_neighbours_for_cell(0, 1)
        assert_equal neighbours.sort, [0, 0, 0, 1, 1]
        # Test for right edge
        neighbours = life.get_neighbours_for_cell(1,3)
        assert_equal neighbours.sort, [0, 0, 0, 1, 1]
        # Test for bottom edge
        neighbours = life.get_neighbours_for_cell(2, 2)
        assert_equal neighbours.sort, [0, 0, 1, 1, 1]
        # Test for left edge
        neighbours = life.get_neighbours_for_cell(1, 0)
        assert_equal neighbours.sort, [0, 0, 0, 1, 1]
    end

    def test_get_next_state_for_cell
        test_state = [
            [0, 1, 0, 1],
            [0, 1, 1, 1],
            [0, 0, 0, 0]
        ]

        rows, cols = 3, 4
        life = GameOfLife.new(rows, cols)
        life.current_state = test_state

        # Test for middle position
        cell_next_state = life.get_next_state_for_cell(1, 2)
        assert_equal cell_next_state, 0

        # Test for top left corner
        cell_next_state = life.get_next_state_for_cell(0, 0)
        assert_equal cell_next_state, 0
        # Test for top right corner
        cell_next_state = life.get_next_state_for_cell(0, 3)
        assert_equal cell_next_state, 1
        # Test for bottom left corner
        cell_next_state = life.get_next_state_for_cell(2, 0)
        assert_equal cell_next_state, 0
        # Test for bottom right corner
        cell_next_state = life.get_next_state_for_cell(2, 3)
        assert_equal cell_next_state, 0

        # Test for top edge
        cell_next_state = life.get_next_state_for_cell(0, 1)
        assert_equal cell_next_state, 1
        # Test for right edge
        cell_next_state = life.get_next_state_for_cell(1,3)
        assert_equal cell_next_state, 1
        # Test for bottom edge
        cell_next_state = life.get_next_state_for_cell(2, 2)
        assert_equal cell_next_state, 1
        # Test for left edge
        cell_next_state = life.get_next_state_for_cell(1, 0)
        assert_equal cell_next_state, 0
    end
end
