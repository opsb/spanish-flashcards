require 'yaml'
require 'pry'
require_relative 'lib/conjugation'
require_relative 'lib/verb'

module Verbs
  def self.build(infinitives)
    verbs = []
    Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
      verbs << Verb.new(path)
    end    
    verbs.reject{ |v| infinitives && !infinitives.include?(v.infinitive) }
  end
end

namespace :verbs do
  task :build_flashcards, :verbs, :tenses do |t, args|
    verbs = if args[:verbs]
      verbs = args[:verbs].split(":")
      verbs = nil if verbs == ["all"]
      verbs
    end
    
    tenses = if args[:tenses]
      tenses = args[:tenses].split(":")
      tenses = nil if tenses == ["all"]
      tenses
    end    
    
    verbs = Verbs.build(verbs)
    
    File.open('flashcard_set.txt', 'w') do |f|    
      verbs.map{|v|v.examples(tenses)}.flatten.each do |example|
        f.puts example
      end
    end    

  end
end