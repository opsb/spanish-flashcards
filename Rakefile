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
  
  task :build_similar_phonemes do
    mkdir_p File.expand_path('./sets')  
    similar_phonemes = File.read(File.expand_path('./syllables/similar_phonemes.txt')).split("\n")
    File.open(File.expand_path('./sets/similar_phonemes.txt'), 'w') do |file|
      10.times do
        file.puts similar_phonemes.map{|p|"#{p}\t#{p}"}.join("\n")
      end
    end
  end
end

def read_param(args, key, opts={})
  value = args[key]
  if value
    values = value.split(":")
    values = nil if values == [opts[:nil_if]]
    values
  end
end

namespace :verbs do
  task :build_flashcards, :verbs, :tenses, :track do |t, args|
    verbs = read_param(args, :verbs, :nil_if => "all")
    tenses = read_param(args, :tenses, :nil_if => "all")
    verbs = Loader.load_verbs(verbs, args[:track])
    
    File.open('flashcard_set.txt', 'w') do |f|    
      verbs.map{|v|v.examples(tenses)}.flatten.each do |example|
        f.puts example
      end
    end    

  end
end