require_relative 'display.rb'
require_relative 'db.rb'

class Game
  attr_accessor :available_letters, :solved_letters, :word, :incorrect_letters,:dictionary
  include Display
  include Database
  
  def initialize
    @available_letters = ('A'..'Z').to_a
    @solved_letters = []
    @dictionary = define_dictionary
    @word = get_word.upcase
    @incorrect_letters = []
    start
  end

  def get_word
   word = dictionary[rand(dictionary.length)].chomp
    word
  end

  def define_dictionary
    dictionary = []
    File.open('google-10000-english-no-swears.txt').each do |line|
      dictionary << line if line.length >= 6 && line.length <= 13
    end
    dictionary
  end

  def start
    instructions_text
    new_game_or_load
    hangman(word.length, incorrect_letters, solved_letters,word)
    turns    
  end
  
  def turns
    while incorrect_letters.length < 6
      break if check_win
      save_or_guess
      guess = make_guess(self.available_letters)
      check_guess(guess)
      hangman(word.length, incorrect_letters, solved_letters,word)
      
    end
  end

  def check_guess(guess)
    
    if word.include?(guess)
      solved_letters << guess
      available_letters.delete(guess)
    else
      incorrect_letters << guess
      available_letters.delete(guess)
    end
  end

  def check_win
    if solved_letters.uniq.sort == word.split("").uniq.sort
      puts "Congratulations! You have won!"
      return true
    else
      return false
    end
  end

  def save_or_guess
    puts "Would you like to save the game or make a guess? (1 to save/2 to guess)"
    choice = gets.chomp.downcase
    if choice == "1"
      save_gamefile      
    elsif choice == "2"
      return
    else
      save_or_guess
    end
  end

end