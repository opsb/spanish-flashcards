module Verbs
  class Verb
    def initialize(path)
      @verb = YAML::load(File.read(path))
      @infinitive = @verb.delete(:infinitive)
      @verb_discriminator = @verb.delete(:discriminator)    
    end
    
    def track
      if @infinitive =~ /ar$/
        "ar"
      else
        "er"
      end
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
          conjugation = build_conjugation(tense_name, english_with_discriminator, spanish, english_pronoun(i, tense_name), spanish_pronoun(i, tense_name), opts)
          i += 1
          conjugation
        end.flatten
      end.flatten
    end
    
    def spanish_pronoun(index, tense)
      if tense == :imperfecto && [0,2].include?(index)
        [
          "yo",
          "tu",
          "el",
          "nosotros",
          "vosotros",
          "ellos"
        ][index]
      else
        nil
      end
    end
    
    def english_pronoun(index, tense)
      return "" if tense == :gerundio
      pronouns = [
        "I",
        "you",
        "he",
        "we",
        "you all",
        "they",
      ]
      pronouns[index]      
    end
    
    def build_conjugation(tense_name, english, spanish, english_pronoun, spanish_pronoun, opts={})
      details = [@verb_discriminator]
      details << tense_name if opts[:include_tense]
      details = details.compact.join(", ")
      english_with_details = english_pronoun + " " + english + (details.empty? ? "" : " (#{details})")
      spanish_with_details = spanish_pronoun ? "#{spanish_pronoun } #{spanish}" : spanish
      Conjugation.new(tense_name.to_s, spanish_with_details, english_with_details) 
    end    
  end
end