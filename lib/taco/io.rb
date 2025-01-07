module Taco
  class TacoIO
    def self.read_file(filename)
      raise "File not found: #{filename}" unless File.exist?(filename)
      File.read(filename)
    end

    def self.write_to_console(output)
      puts(output)
    end
  end
end
