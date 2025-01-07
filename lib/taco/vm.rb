module Taco
  class TacoVM
    def initialize(logger)
      @memory = Array.new(30_000, 0)
      @pointer = 0
      @output = ""
      @logger = logger
    end

    def execute(instructions)
      @logger.info("Starting VM execution")
      execution_start = Time.now
      pos = 0
      loop_stack = []

      while pos < instructions.size
        raise "Timeout" if Time.now - execution_start > 1.5
        case instructions[pos]
        when :INC
          @memory[@pointer] += 1
          @memory[@pointer] = 255 if @memory[@pointer] > 255
          @logger.debug("INC: #{@pointer} = #{@memory[@pointer]}")
        when :DEC
          @memory[@pointer] -= 1
          @memory[@pointer] = 0 if @memory[@pointer] < 0
          @logger.debug("DEC: #{@pointer} = #{@memory[@pointer]}")
        when :RIGHT
          @pointer = (@pointer + 1) % @memory.size
          @logger.debug("RIGHT: pointer = #{@pointer}")
        when :LEFT
          @pointer = (@pointer - 1) % @memory.size
          @logger.debug("LEFT: pointer = #{@pointer}")
        when :PRINT
          char = @memory[@pointer].chr
          @output += char
          @logger.debug("PRINT: #{char.inspect} (#{@memory[@pointer]})")
        when :JUMP_IF_ZERO
          if @memory[@pointer].zero?
            loop_end = instructions.index(:JUMP_IF_NONZERO, pos + 1)
            raise "Unmatched loop start at position #{pos}" unless loop_end
            pos = loop_end
          else
            loop_stack.push(pos)
          end

        when :JUMP_IF_NONZERO
          if @memory[@pointer] != 0
            raise "Unmatched loop end at position #{pos}" if loop_stack.empty?
            pos = loop_stack.last - 1
          else
            loop_stack.pop
          end
        else
          @logger.error("Unknown instruction: #{instructions[pos]}")
          raise "Unknown instruction at position #{pos}"
        end

        pos += 1
      end

      @logger.info("VM execution completed in #{Time.now - execution_start}s")
      @output
    end
  end
end
