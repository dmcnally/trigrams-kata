# Trigrams

## Overview

This is an attempt at a Dave Thomas kata: [Kata Fourteen: Tom Swift Under Milk Wood](http://codekata.pragprog.com/2007/01/kata_fourteen_t.html)

## Thinking

Initially there are probably 3 pieces:

 * Word reader
 * Trigram Hash
 * Text generator
 
### Word Reader

The word reader would take a file stream, reads a line at a time and splits the line based on spaces (This should give a rough way of quickly generating words).  Each word is fed in turn to a trigram hash object.

The word reader doesn't have any knowledge of the trigram algorithm.  It's sole purpose is to take an input stream and tell another object about the words it finds in the order it finds them.  

_Note: I didn't implement this piece of the puzzle._

### Trigram Hash

This object is responsible for building the trigram hash. It takes a word at a time and contructs the appropriate hash in memory.

The object also has a 'generate' method.  This takes another object as a parameter and calls methods on it.

    trigram_hash.generate(text_generator)


### Text Generator

Used to generate a document.  A text generator is passed to the generate method of the trigram hash.  The trigram hash will call methods on the text generate.  It is the responsibility of the text generate to string the words together to form a piece of text.

A text generator responds to the following methods:

  * on_start
  * on_word(word)
  * on_completed
  
The generated text is returned using the "to_s" method.

## Discussion Points

 * I didn't implement the loading of a file from disk. (There are more interesting points than this)
 * Application is limited by amount of available memory ( Yes I realise this is in the comments for the Kata )
 * Should be trivial to make the trigram work with n words as the key
 * There are some interesting issues to overcome with regards to testing the generation of mutated text
   * What are the criteria for stopping text generation? 
   * How do we deal with a scenario where the new text won't reach a terminal state? Max word count?
   * How do we validate the mutated text is achievable?
     * Fix the random number generator?
     * Check the first and last word are reachable?
     * Validate the generated text against the trigram hash?
       * Would checking each pair of words is a valid key suffice?
