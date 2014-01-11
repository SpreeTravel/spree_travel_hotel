module SpreeTravelHotel
  module Data
    def self.load_data(file)
      path = File.expand_path(data_path + "#{file}.rb")
      # Check to see if the specified file has been loaded before
      if !$LOADED_FEATURES.include?(path)
        require path
        puts "Loaded #{file.titleize} hotels data"
      end
    end

    private
    def self.data_path
      Pathname.new(File.join(File.dirname(__FILE__), '..', '..', 'db', 'data'))
    end
  end
end