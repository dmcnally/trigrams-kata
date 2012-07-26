class TextGenerator
  
  attr_reader :generated_text
  
  def initialize
    @generated_text = ''
  end
  
  def on_start
    @generated_text = ''
  end
  
  def on_word(word)
    @generated_text << ' ' unless @generated_text == ''
    @generated_text << word
  end
  
  def on_complete
  end
  
  def to_s
    generated_text
  end
  
end