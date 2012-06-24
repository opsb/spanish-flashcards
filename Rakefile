require 'yaml'
require 'pry'

module Verbs
  def self.build_examples(path, verbs)
    examples = []
    Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
      examples.concat Verb.new(path, verbs).examples
    end    
    examples
  end
  
  class Verb
    def initialize(path, verbs)
      verb = YAML::load(File.read(path))
      infinitive = verb.delete(:infinitive)
      verb_discriminator = verb.delete(:discriminator)    
      @examples = build_examples(verb, infinitive, verb_discriminator, verbs)
    end
    
    def build_examples(verb, infinitive, verb_discriminator, verbs)
      examples = []
      unless verbs && !verbs.include?(infinitive)
        verb.each do |verb_name, conjugations|
          conjugations.each do |english_with_discriminator, spanish|
            examples << build_example(verb_name, english_with_discriminator, spanish, verb_discriminator)
          end
        end
      end   
      examples   
    end
    
    def build_example(verb_name, english_with_discriminator, spanish, verb_discriminator)
      begin
        english, conjugation_discriminator = *english_with_discriminator.match(/([^(]+)(?:\(([^)]+)\))?/)[1,2]
      rescue
        binding.pry
      end
      details = [conjugation_discriminator, verb_discriminator, verb_name].compact.join("/")
      [spanish, english + "(#{details})" ].join(",")    
    end    
    
    def examples
      @examples
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