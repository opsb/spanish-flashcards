module Verbs
  class Conjugation
    def initialize(spanish, english)
      @spanish = spanish
      @english = english
    end
    def text
      [@spanish, @english].join("\t")      
    end
  end
end