require 'yaml'
require 'pry'
require_relative 'lib/conjugation'
require_relative 'lib/verb'
require_relative 'lib/loader'

namespace :verbs do
  task :build_flashcards, :verbs, :tenses, :track do |t, args|
    verbs = if args[:verbs]
      verbs = args[:verbs].split(":")
      verbs = nil if verbs == ["all"]
      verbs
    end
    
    tenses = if args[:tenses]
      tenses = args[:tenses].split(":")
      tenses = nil if tenses == ["all"]
      tenses.map(&:to_sym)
    end    
    
    verbs = Loader.load_verbs(verbs, args[:track])
    
    File.open('flashcard_set.txt', 'w') do |f|    
      verbs.map{|v|v.examples(tenses)}.flatten.each do |example|
        f.puts example
      end
    end    

  end
end