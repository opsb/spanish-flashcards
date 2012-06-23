require 'yaml'
require 'pry'

namespace :verbs do
  task :build_flashcards, :verbs do |t, args|
    if args[:verbs]
      verbs = args[:verbs].split(":")
      puts verbs
    end
    File.open('flashcard_set.txt', 'w') do |f|
      Dir.glob(File.expand_path('./verbs/*.yaml')) do |path|
        verb = YAML::load(File.read(path))
        infinitive = verb.delete(:infinitive)
        discriminator = verb.delete(:discriminator)        
        unless verbs && !verbs.include?(infinitive)
          verb.each do |name, conjugations|
            conjugations.each do |english_with_discriminator, spanish|
              begin
                english, conjugation_discriminator = *english_with_discriminator.match(/([^(]+)(?:\(([^)]+)\))?/)[1,2]
              rescue
                binding.pry
              end
              details = [conjugation_discriminator, discriminator, name].compact.join("/")
              f.puts [spanish, english + "(#{details})" ].join(",")
            end
          end
        end
      end
    end
  end
end