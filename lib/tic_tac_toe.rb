require "pry"
class TicTacToe
attr_accessor :board
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]
    def initialize
        @board = board || Array.new(9, " ")
        @@count = 0
    end

    def display_board
       puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
       puts "-----------"
       puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
       puts "-----------"
       puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        index = input.to_i - 1
        index
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        if !position_taken?(index) && index.between?(0,8)
            return true
        else
            return false
        end
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Choose a move"
        input = gets
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |winning_combo|
            win_index_1 = winning_combo[0]
            win_index_2 = winning_combo[1]
            win_index_3 = winning_combo[2]

            position_1 = board[win_index_1]
            position_2 = board[win_index_2]
            position_3 = board[win_index_3]
            if position_1 == position_2 && position_1 == position_3 && (position_1 == "X" || position_1 == "O")
                return winning_combo
            end
        end
        return false
    end

    def full?
        if board.any? {|index| index == " "} 
        return false
        else
            return true
        end
    end

    def draw?
        if !won? && full?
            return true
        elsif !full? && !won?
            return false
        else won?
            return false
        end
    end
    def over?
        if draw? || won? || full?
            return true
        else
            return false
        end
    end

    def winner
        if won? != false
            return board[won?[0]]
        else 
            return nil
        end
    end

    def play
        until over? == true
            turn
    end
    if won? != false
        puts "Congratulations #{winner}!"
    else
        puts "Cat's Game!"
    end
    end
end