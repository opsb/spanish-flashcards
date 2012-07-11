module Loader
  class << self
    def load_verbs(infinitives, track)
      verbs = []
      Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
        verbs << Verbs::Verb.new(path)
      end    

      verbs.reject{ |v| infinitives && !infinitives.include?(v.infinitive) }.
            reject{ |v| track && (v.track != track) }      
    end
  end
end