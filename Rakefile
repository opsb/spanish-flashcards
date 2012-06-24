require 'yaml'
require 'pry'
require_relative 'lib/conjugation'
require_relative 'lib/verb'

module Verbs
  def self.build_verbs
    verbs = []
    Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
      verbs << Verb.new(path)
    end    
    verbs
  end
end

namespace :verbs do
  task :build_flashcards, :verbs do |t, args|

    verbs = if args[:verbs]
      verbs = args[:verbs].split(":")
    end
    
    verbs = Verbs.build_verbs().reject{ |v| verbs && !verbs.include?(v.infinitive) }
    
    File.open('flashcard_set.txt', 'w') do |f|    
      verbs.map(&:examples).flatten.each do |example|
        f.puts example
      end
    end    

  end
end