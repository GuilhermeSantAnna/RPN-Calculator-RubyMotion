class CalculatorBrain

  attr_accessor :operand_stack

  def initialize
    @operand_stack = []
  end

  def push_operand(operand)
    @operand_stack << operand
  end

  def pop_operand
    operand_object = @operand_stack.last
    @operand_stack.delete(@operand_stack.last) if operand_object
    operand_object
  end

  def perform_operation(operation)
    puts "operation => #{operation}"
    result = 0

    case operation
      when "+"
        result = pop_operand.to_f + pop_operand.to_f
      when "*"
        result = pop_operand.to_f * pop_operand.to_f
      when "-"
        subtrahend = pop_operand
        result = pop_operand.to_f - subtrahend.to_f
      when "/"
        divisor = pop_operand
        result = pop_operand.to_f / divisor.to_f if divisor
    end

    push_operand(result)

    result
  end

end