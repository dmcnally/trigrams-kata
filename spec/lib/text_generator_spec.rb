require 'text_generator'

describe TextGenerator do
  
  it 'should clear the text on the on start event' do
    subject.on_start
    subject.to_s.should == ''
  end
  
  it 'should append each word in the on word event to the output' do
    subject.on_start
    subject.on_word('The')
    subject.on_word('quick')
    subject.on_word('brown')
    subject.on_word('fox')
    
    subject.to_s.should == 'The quick brown fox'
  end
  
end
