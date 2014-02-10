require 'optparse'

class ArgumentParser
  def self.parse
    options = { environment: "production" }
    OptionParser.new do |opts|
      opts.banner = "Usage: jury [command] [options]"

      opts.on("--name [NAME]", "The name of the song") do |name|
        options[:name] = name
      end

      opts.on("--artist [ARTIST]", "The artist performing the song") do |artist|
        options[:artist] = artist
      end

      opts.on("--intensity [INTENSITY]", "The song\'s intensity value (1 through 5)") do |intensity|
        options[:intensity] = intensity
      end

      opts.on("--focusing [FOCUSING]", "The song\'s focusing value (0 for false; 1 for true)") do |focusing|
        options[:focusing] = focusing
      end

      opts.on("--id [ID]", "The id of the song object") do |id|
        options[:id] = id
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end
    end.parse!
    options[:name] ||= ARGV[1]
    options[:command] = ARGV[0]
    options
  end

  def self.validate options
    errors = []
    if options[:name].nil? or options[:name].empty?
      errors << "I\'ll need the name of the song you\'re adding."
    end

    missing_things = []
    missing_things << "artist" unless options[:artist]
    missing_things << "intensity" unless options[:intensity]
    missing_things << "focusing value" unless options[:focusing]
    unless missing_things.empty?
      errors << "I\'ll need the #{missing_things.join(" and ")} of the song you\'re adding."
    end
    errors
  end
end
