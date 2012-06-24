module Verbs
  class Verb
    def initialize(path)
      verb = YAML::load(File.read(path))
      @infinitive = verb.delete(:infinitive)
      @verb_discriminator = verb.delete(:discriminator)    
      @examples = build_examples(verb)
    end
    
    def examples
      @examples.map(&:text)
    end    
    
    def infinitive
      @infinitive
    end
    
    private
    def build_examples(verb)
      examples = []
      verb.each do |tense_name, conjugations|
        conjugations.each do |english_with_discriminator, spanish|
          examples << build_example(tense_name, english_with_discriminator, spanish)
        end
      end
      examples   
    end
    
    def build_example(tense_name, english, spanish)
      details = [@verb_discriminator, tense_name].compact.join("/")
      Conjugation.new(spanish, english + "(" + [@verb_discriminator, tense_name].compact.join(",") + ")") 
    end    
  end
end