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
      examples = build_conjugations(@verb)
      examples.reject{ |e| tenses && !tenses.include?(e.tense) }.map(&:text)
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
          conjugation = Conjugation.new :tense => tense_name.to_sym,
                                        :english => english_with_discriminator,
                                        :spanish => spanish,
                                        :pronoun_index => i,
                                        :include_tense => opts[:include_tense]
          i += 1
          conjugation
        end.flatten
      end.flatten
    end
  end
end