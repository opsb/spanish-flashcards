module Verbs
  class Conjugation
    SPANISH_PRONOUNS = [
      "yo",
      "tu",
      "el",
      "nosotros",
      "vosotros",
      "ellos"
    ]
    
    ENGLISH_PRONOUNS = [
      "I",
      "you",
      "he",
      "we",
      "you all",
      "they"
    ]
    
    def initialize(opts={})
      @tense = opts[:tense]
      @english = opts[:english]
      @spanish = opts[:spanish]
      @pronoun_index = opts[:pronoun_index]
      @include_tense = opts[:include_tense]
      @tense = tense
    end

    def tense
      @tense
    end
    
    def text
      [spanish, english].join("\t")
    end
    
    def spanish
      spanish_pronoun ? "#{spanish_pronoun } #{@spanish}" : @spanish
    end
    
    def english
      details = [@verb_discriminator]
      details << tense.to_s if @include_tense
      details = details.compact.join(", ")      
      english_pronoun + " " + @english + (details.empty? ? "" : " (#{details})")      
    end
    
    def spanish_pronoun
      if @tense == :imperfecto && [0,2].include?(@pronoun_index)
        SPANISH_PRONOUNS[@pronoun_index]
      else
        nil
      end
    end
    
    def english_pronoun
      return "" if @tense == :gerundio
      ENGLISH_PRONOUNS[@pronoun_index]
    end
  end
end