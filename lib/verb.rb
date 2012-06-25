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
        i = 0
        conjugations.map do |(hash)|
          english_with_discriminator, spanish = hash.keys.first, hash.values.first     
          conjugation = build_conjugation(tense_name, english_with_discriminator, spanish, pronoun(i, tense_name))
          i += 1
          conjugation
        end.flatten
      end.flatten
    end
    
    def pronoun(index, tense)
      pronouns = [
        "I",
        "You",
        "He/She/They",
        "We",
        "You (all)",
        "They (all)"
      ]
      return "" if tense == :gerundio
      pronouns[index]      
    end
    
    def build_conjugation(tense_name, english, spanish, pronoun)
      details = [@verb_discriminator, tense_name].compact.join("/")
      Conjugation.new(tense_name.to_s, spanish, pronoun + " " + english + "(" + [@verb_discriminator, tense_name].compact.join(",") + ")") 
    end    
  end
end