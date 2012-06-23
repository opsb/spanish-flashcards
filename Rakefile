require 'yaml'
require 'pry'

namespace :verbs do
  task :build_flashcards do
    File.open('flashcard_set.txt', 'w') do |f|
      Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
        verb = YAML::load(File.read(path))
        infinitive = verb.delete(:infinitive)
        verb.each do |name, conjugations|
          conjugations.each do |english, spanish|
            if english =~ /\(.+\)/
              english = english.gsub("\)", "/#{name})")
            else
              english = english + " (#{name})"
            end
            f.puts [spanish, english].join(",")
          end
        end
      end
    end
  end
end