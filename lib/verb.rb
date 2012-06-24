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
      Conjugation.new(spanish, english + "(#{details})" ) 
    end    
  end
end