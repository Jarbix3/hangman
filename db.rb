require 'yaml'


module Database
  def save_gamefile
    Dir.mkdir("saved_games") unless Dir.exist? "saved_games"
    filename = "#{rand(1000..9999)}_game.yaml"
    File.open("saved_games/#{filename}", "w") {|file| file.write save_state}
    puts "Game saved as #{filename}"
  end

 

  def save_state
    YAML.dump(
      'available_letters' => @available_letters,
      'solved_letters' => @solved_letters,
      'word' => @word,
      'incorrect_letters' => @incorrect_letters      
    )
  end

  def load_gamefile
    show_gamefiles
    puts "Please enter the number of the file you would like to load: "
    filename = gets.chomp

    if File.exist?("saved_games/#{filename}" + "_game.yaml")
      load_state(filename+ "_game.yaml")
    else
      puts "File not found."
      load_gamefile
    end
  end

  

  def new_game_or_load
    puts "Would you like to start a new game or load a saved game? (new/load)"
    choice = gets.chomp.downcase
    if choice == "load"
      load_gamefile
    elsif choice == "new"
      return
    else
      new_game
    end
  end

  def show_gamefiles
    puts "Saved games:"
    Dir.entries("saved_games").each do |file|
      puts file if file.match(/.yaml$/)
        
      end
  end
  
  def load_state(filename)
    data = YAML.load_file("saved_games/#{filename}")
    @available_letters = data['available_letters']
    @solved_letters = data['solved_letters']
    @word = data['word']
    @incorrect_letters = data['incorrect_letters']
    puts "Game loaded."
    hangman(word.length, incorrect_letters, solved_letters,word)
    turns
  end

end