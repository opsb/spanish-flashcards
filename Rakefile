require 'yaml'
require 'pry'

module Verbs
  def self.build_examples(path, verbs)
    examples = []
    Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
      verb = Verb.new(path)
      unless verbs && !verbs.include?(verb.infinitive)
        examples.concat verb.examples        
      end
    end    
    examples
  end
  
  class Example
    def initialize(spanish, english)
      @spanish = spanish
      @english = english
    end
    def text
      [@spanish, @english].join(",")      
    end
  end
  
  class Verb
    def initialize(path)
      verb = YAML::load(File.read(path))
      @infinitive = verb.delete(:infinitive)
      @verb_discriminator = verb.delete(:discriminator)    
      @examples = build_examples(verb)
    end
    
    def build_examples(verb)
      examples = []
      verb.each do |verb_name, conjugations|
        conjugations.each do |english_with_discriminator, spanish|
          examples << build_example(verb_name, english_with_discriminator, spanish)
        end
      end
      examples   
    end
    
    def build_example(verb_name, english_with_discriminator, spanish)
      begin
        english, conjugation_discriminator = *english_with_discriminator.match(/([^(]+)(?:\(([^)]+)\))?/)[1,2]
      rescue
        binding.pry
      end
      details = [conjugation_discriminator, @verb_discriminator, verb_name].compact.join("/")
      Example.new(spanish, english + "(#{details})" ) 
    end    
    
    def examples
      @examples.map(&:text)
    end
  end
  
  def self.load(path, verbs)
    File.open('flashcard_set.txt', 'w') do |f|    
      build_examples(path, verbs).each do |example|
        f.puts example
      end
    end        
  end
end

namespace :verbs do
  task :build_flashcards, :verbs do |t, args|

    verbs = if args[:verbs]
      verbs = args[:verbs].split(":")
    end
    
    Verbs.load('./verbs/*.yaml', verbs)
  end
end