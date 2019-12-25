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
end
