module Verbs
  class Conjugation
    def initialize(tense, spanish, english)
      @spanish = spanish
      @english = english
      @tense = tense
    end
    
    def tense
      @tense
    end
    
    def text
      [@spanish, @english].join("\t")      
    end
  end
end