require 'pry'

class TrigramHash
  
  PHRASE_SIZE = 3
  PHRASE_RANGE = 0..(PHRASE_SIZE - 2)
  
  attr_reader :words,
              :word_hash 
  
  def initialize
    @words = []
    @word_hash = {}
  end
  
  def add_word(word)
    @words << word
    words_size = @words.size
    
    if words_size >= PHRASE_SIZE
      @words.shift if words_size > PHRASE_SIZE
      key = @words[PHRASE_RANGE].join(' ')
      value = @words[-1]
      
      value_array = @word_hash[key] || []
      value_array << value
      @word_hash[key] = value_array
    end
  end
  
  def generate(generator)
    generator.on_start
    words = start_phrase.split(' ')
    words.each do |word|
      generator.on_word(word)
    end

    current_phrase = words[PHRASE_RANGE].join(' ')
    while can_continue_building_text?(current_phrase)
      next_word = get_next_word(current_phrase)
      words << next_word
      words.shift if words.size >= PHRASE_SIZE
      current_phrase = words[PHRASE_RANGE].join(' ')  

      generator.on_word(next_word)
    end
    
    generator.on_complete
  end
  
  def count
    word_hash.size
  end
  
  private
  
  def start_phrase
    word_hash.keys[rand(count) - 1]
  end
  
  def can_continue_building_text?(current_phrase)
    word_hash.keys.include?(current_phrase)
  end
  
  def get_next_word(current_phrase)
    word_list = word_hash[current_phrase]
    word_list[rand(word_list.size) - 1]
  end
    
end