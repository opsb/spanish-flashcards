module Verbs
  class Verb
    def initialize(infinitive, discriminator, tenses)
      @infinitive = infinitive
      @verb_discriminator = discriminator
      @tenses = tenses
    end
    
    def track
      @infinitive =~ /ar$/ ? "ar" : "er"
    end

    def examples(tenses)
      filtered_tenses = @tenses.reject{ |t| tenses && !tenses.include?(t.name) }
      filtered_tenses.map(&:examples).flatten.map(&:text)
    end

    def infinitive
      @infinitive
    end
  end
end