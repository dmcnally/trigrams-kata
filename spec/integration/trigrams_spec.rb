require 'text_generator'
require 'trigram_hash'

describe 'Generating trigrams' do
  
  # This is an example of testing the trigram generation.
  it 'should return the full or shorter version of the string when mutation is not possible' do    
    trigram_hash = TrigramHash.new
    
    words = %w( I do not like green eggs and ham )
    words.each{|word| trigram_hash.add_word(word) }
    
    valid_responses = [
      'I do not like green eggs and ham',
      'do not like green eggs and ham',
      'not like green eggs and ham',
      'like green eggs and ham',
      'green eggs and ham',
      'eggs and ham',
      ]
    
    20.times do 
      text_generator = TextGenerator.new

      trigram_hash.generate(text_generator)
    
      valid_responses.should include(text_generator.to_s)
    end
    
  end
  
  xit 'should return mutated versions of the the when mutation is possible' do    
    trigram_hash = TrigramHash.new
    
    words = %w( I do not like them Sam I am I do not like green eggs and ham )
    words.each{|word| trigram_hash.add_word(word) }
    
    initial_word_hash = trigram_hash.word_hash
      
    text_generator = TextGenerator.new

    trigram_hash.generate(text_generator)
    
    text_generator.to_s
    #
    # 
    #
  end
    
end