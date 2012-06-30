module Verbs
  class Verb
    def initialize(path)
      @verb = YAML::load(File.read(path))
      @infinitive = @verb.delete(:infinitive)
      @verb_discriminator = @verb.delete(:discriminator)    
    end
    
    def examples(tenses)
      opts = { :include_tense => true } if tenses.size > 1
      build_conjugations(@verb).reject{ |e| tenses && !tenses.include?(e.tense) }.map(&:text)
    end    
    
    def infinitive
      @infinitive
    end
    
    private
    def build_conjugations(verb, opts={})
      verb.map do |tense_name, conjugations|
        i = 0
        conjugations.map do |(hash)|
          english_with_discriminator, spanish = hash.keys.first, hash.values.first     
          conjugation = build_conjugation(tense_name, english_with_discriminator, spanish, pronoun(i, tense_name), opts)
          i += 1
          conjugation
        end.flatten
      end.flatten
    end
    
    def pronoun(index, tense)
      pronouns = [
        "I",
        "you",
        "he/she/it",
        "we",
        "you all",
        "they all"
      ]
      return "" if tense == :gerundio
      pronouns[index]      
    end
    
    def build_conjugation(tense_name, english, spanish, pronoun, opts={})
      details = [@verb_discriminator]
      details << tense_name if opts[:include_tense]
      details = details.compact.join(", ")
      english_with_details = english + (details.empty? ? "" : " - #{details}")
      
      Conjugation.new(tense_name.to_s, spanish, pronoun + " " + english_with_details) 
    end    
  end
end