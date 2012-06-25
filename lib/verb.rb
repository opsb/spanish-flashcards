module Verbs
  class Verb
    def initialize(path)
      verb = YAML::load(File.read(path))
      @infinitive = verb.delete(:infinitive)
      @verb_discriminator = verb.delete(:discriminator)    
      @examples = build_conjugations(verb)
    end
    
    def examples(tenses)
      @examples.reject{ |e| tenses && !tenses.include?(e.tense) }.map(&:text)
    end    
    
    def infinitive
      @infinitive
    end
    
    private
    def build_conjugations(verb)
      verb.map do |tense_name, conjugations|
        conjugations.map do |english_with_discriminator, spanish|
          build_conjugation(tense_name, english_with_discriminator, spanish)
        end.flatten
      end.flatten
    end
    
    def build_conjugation(tense_name, english, spanish)
      details = [@verb_discriminator, tense_name].compact.join("/")
      Conjugation.new(tense_name.to_s, spanish, english + "(" + [@verb_discriminator, tense_name].compact.join(",") + ")") 
    end    
  end
end