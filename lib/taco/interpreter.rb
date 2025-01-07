require "emoji_regex"

module Taco
  class TacoInterpreter
    INSTRUCTION_MAP = {
      "🌮" => :INC,
      "🌯" => :DEC,
      "🥙" => :RIGHT,
      "🫔" => :LEFT,
      "🔥" => :PRINT,
      "🏃" => :JUMP_IF_ZERO,
      "🔙" => :JUMP_IF_NONZERO
    }.freeze

    def initialize
      @logger = TacoLogger.create_logger
      @vm = TacoVM.new(@logger)
    end

    def parse_code(code)
      instructions = []

      code.lines.each do |line|
        line = line.split("#").first.strip
        line.scan(EmojiRegex::Regex) do |emoji|
          instruction = INSTRUCTION_MAP[emoji]
          if instruction
            instructions << instruction
          else
            @logger.error("Unknown emoji: #{emoji}")
            raise "Unknown taco instruction: #{emoji}"
          end
        end
      end

      instructions
    end

    def run(file_path)
      code = TacoIO.read_file(file_path)
      instructions = parse_code(code)
      output = @vm.execute(instructions)
      TacoIO.write_to_console(output)
    end
  end
end
