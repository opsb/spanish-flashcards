require 'yaml'
require 'pry'
require_relative 'lib/conjugation'
require_relative 'lib/verb'
require_relative 'lib/tense'
require_relative 'lib/loader'
include FileUtils

namespace :phonemes do
  task :build_rhyming_sets do
    mkdir_p File.expand_path('./sets')
    phonemes = File.read(File.expand_path('./syllables/phonemes.txt')).split("\n")
    rhyming = phonemes.group_by{|p| p[/^([^(]+)/, 1].strip[-1] }
    rhyming.each do |rhyming_letter, phonemes|
      File.open(File.expand_path('./sets/phonemes_rhyming_with_' + rhyming_letter + '.txt'), 'w') do |file|
        file.write(phonemes.join("\n"))
      end
    end
  end
end

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