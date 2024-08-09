
module Display
  def instructions_text
    puts "Welcome to the game of Hangman!\n\n"
    puts "The computer will choose a random word and you will have to guess it.\n"
    puts "You can guess one letter at a time.\n"
    puts "If you guess a letter that is in the word, it will be revealed.\n"
    puts "If you guess a letter that is not in the word, you will lose a life.\n"
    puts "You have 6 lives.\n"
    puts "Good luck!\n"
  end

  def hangman(word_size, incorrect_letters, solved_letters,word)

    
    puts "\n\n\t\t\t\tHANGMAN\n\n"

    word_size.times do |i|
      
      if solved_letters.include?(word[i])
        print word[i] + " "
      else
        print "_ "
      end
      
    end
    puts "\n\n"
    puts "Lives: #{6 - incorrect_letters.length}\n\n"
    puts "Incorrect guesses: #{incorrect_letters.join(", ")}\n\n"
   
    

  end

  def make_guess(available_letters)
    puts "Please guess a letter: "
    guess = gets.chomp.upcase
    return guess if guess.to_s.match(/[A-Z]$/) && guess.length == 1 && available_letters.include?(guess)
    make_guess(available_letters)
  end



end