module Loader
  class << self
    def load_verbs(infinitives, track)
      verbs = []
      Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
        verbs << load_verb(path)
      end    

      verbs.reject{ |v| infinitives && !infinitives.include?(v.infinitive) }.
            reject{ |v| track && (v.track != track) }      
    end
    
    def load_verb(path)
      verb = YAML::load(File.read(path))
      Verbs::Verb.new(
        verb.delete(:infinitive),
        verb.delete(:discriminator),
        load_tenses(verb)
      )
    end
    
    def load_tenses(verb)
      verb.map do |tense_name, conjugations|
        Tense.new :name => tense_name,
                  :conjugations => load_conjugations(conjugations, tense_name)
      end
    end
    
    def load_conjugations(conjugations, tense_name)
      i = 0
      conjugations.map do |(hash)|
        english_with_discriminator, spanish = hash.keys.first, hash.values.first
        conjugation = Verbs::Conjugation.new :tense => tense_name.to_sym,
                                      :english => english_with_discriminator,
                                      :spanish => spanish,
                                      :pronoun_index => i,
                                      :include_tense => true
        i += 1
        conjugation
      end.flatten
    end 
  end
end