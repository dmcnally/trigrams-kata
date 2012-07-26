require 'trigram_hash'

describe TrigramHash do
  
  context 'when adding words' do

    it 'should track words that are added to the hash' do
    
      words = %w( the quick brown fox jumped over the lazy dog )
    
      words.each do |word|
        subject.add_word(word)
      end
    
      subject.word_hash.should == {
        'the quick' => ['brown'],
        'quick brown' => ['fox'],
        'brown fox' => ['jumped'],
        'fox jumped' => ['over'],
        'jumped over' => ['the'],
        'over the' => ['lazy'],
        'the lazy' => ['dog']
      }
    
    end
  
    it 'should record multiple values for the mapping when the key exists in the text multiple times' do
      words = %w( That Sam I am that Sam I am I do not like that Sam I am)
    
      words.each do |word|
        subject.add_word(word)
      end
    
      subject.word_hash.should == {
        "That Sam" => ["I"],
        "Sam I" => ["am", "am"],
        "am that" => ["Sam"],
        "I am" => ["that", "I"],
        "am I" => ["do"],
        "I do" => ["not"],
        "do not" => ["like"],
        "not like" => ["that"],
        "Sam I" => ["am", "am", "am"],
        "that Sam" => ["I", "I"],
        "like that" => ["Sam"],
      }
   
    end
    
  end
  
  context 'when generating text' do
    
    let(:text_generator) { double('TextGenerator').as_null_object }
    let(:word_hash) { 
      {
        'I am' => ['Sam'],
        'am Sam' => ['that']
      }
    }
    
    before(:each) do
      subject.stub(:word_hash).and_return(word_hash)
    end
    
    context 'starting a generation run' do

      
      it 'should call on start on the generator' do
        text_generator.should_receive(:on_start)
      
        subject.stub(:word_hash).and_return(word_hash)
        subject.generate(text_generator)
      end

      it 'should on word on the generator for each word in the start point' do
        text_generator.should_receive(:on_word).with('I').ordered
        text_generator.should_receive(:on_word).with('am').ordered

        subject.stub(:start_phrase).and_return('I am')

        subject.generate(text_generator)
      end

    end
    
    it 'should call on word for each word in the generated text' do
      text_generator.should_receive(:on_word).with('I').ordered
      text_generator.should_receive(:on_word).with('am').ordered
      text_generator.should_receive(:on_word).with('Sam').ordered
      text_generator.should_receive(:on_word).with('that').ordered

      subject.stub(:start_phrase).and_return('I am')

      subject.generate(text_generator)
    end
    
    it 'should call on complete when no more words can be generated' do
      text_generator.should_receive(:on_complete)
      subject.generate(text_generator)
    end
        
  end
  
end