class CalculatorViewController < UIViewController

  attr_reader :label, :userIsInTheMiddleOfEnteringANumber, :brain

  def loadView
    self.view = UIView.alloc.init
    self.view.backgroundColor = UIColor.whiteColor
  end

  def viewDidLoad
    @userIsInTheMiddleOfEnteringANumber = false
    @brain = CalculatorBrain.alloc.init

    # label for display
    @label = makeLabel
    view.addSubview(@label)

    # calc buttons
    seven_button = makeButton(title: "7", x: 20,  y: 60)
    view.addSubview(seven_button)
    seven_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    eight_button = makeButton(title: "8", x: 90,  y: 60)
    view.addSubview(eight_button)
    eight_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    nine_button = makeButton(title: "9", x: 160, y: 60)
    view.addSubview(nine_button)
    nine_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    multiplication_button = makeButton(title: "*", x: 230, y: 60)
    view.addSubview(multiplication_button)
    multiplication_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    four_button = makeButton(title: "4", x: 20,  y: 110)
    view.addSubview(four_button)
    four_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    five_button = makeButton(title: "5", x: 90,  y: 110)
    view.addSubview(five_button)
    five_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    six_button = makeButton(title: "6", x: 160, y: 110)
    view.addSubview(six_button)
    six_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    division_button = makeButton(title: "/", x: 230, y: 110)
    view.addSubview(division_button)
    division_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    one_button = makeButton(title: "1", x: 20,  y: 160)
    view.addSubview(one_button)
    one_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    two_button = makeButton(title: "2", x: 90,  y: 160)
    view.addSubview(two_button)
    two_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    three_button = makeButton(title: "3", x: 160, y: 160)
    view.addSubview(three_button)
    three_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    plus_button = makeButton(title: "+", x: 230, y: 160)
    view.addSubview(plus_button)
    plus_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    clear_button = makeButton(title: "C", x: 20,  y: 210)
    view.addSubview(clear_button)
    clear_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    zero_button = makeButton(title: "0", x: 90,  y: 210)
    view.addSubview(zero_button)
    zero_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    enter_button = makeButton(title: "Enter", x: 160,  y: 210)
    view.addSubview(enter_button)
    enter_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)

    minus_button = makeButton(title: "-", x: 230,  y: 210)
    view.addSubview(minus_button)
    minus_button.performSelector("brightness=:", withObject:0.1, afterDelay:0)
  end

  def makeLabel
    label = UILabel.alloc.initWithFrame([[10,20], [300,30]])
    label.text = "0"
    label.textAlignment = UITextAlignmentRight
    label.font = UIFont.boldSystemFontOfSize(20)
    label
  end

  def makeButton(options = {})
    options[:title] = "title" unless options[:title]
    options[:x] = 20 unless options[:x]
    options[:y] = 60 unless options[:y]

    # button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button = CoolButton.alloc.initWithFrame([[options[:x], options[:y]], [70, 50]])
    button.setTitle(options[:title], forState:UIControlStateNormal)
    
    case button.currentTitle
      when "Enter"
        button.addTarget(self, action: 'enter_pressed:', forControlEvents:UIControlEventTouchUpInside)
      when "C"
        button.addTarget(self, action: 'clear_pressed:', forControlEvents:UIControlEventTouchUpInside)
      when "+", "-", "*", "/"
        button.addTarget(self, action: 'operation_pressed:', forControlEvents:UIControlEventTouchUpInside)
      else
        button.addTarget(self, action: 'digit_pressed:', forControlEvents:UIControlEventTouchUpInside)
    end
    

    button
  end

  def digit_pressed(button)
    @calculator_brain = CalculatorBrain.alloc.init
    @calculator_brain.push_operand("+")

    if @userIsInTheMiddleOfEnteringANumber
      @label.text = "#{@label.text}#{button.currentTitle}"
    else
      @label.text = button.currentTitle
      @userIsInTheMiddleOfEnteringANumber = true
    end
  end

  def enter_pressed(button)
    @brain.push_operand(@label.text)
    @userIsInTheMiddleOfEnteringANumber = false
  end

  def operation_pressed(button)
    enter_pressed(button) if @userIsInTheMiddleOfEnteringANumber

    result = @brain.perform_operation(button.currentTitle)
    result = result.to_i if result == result.to_i

    @label.text = result.to_s
  end

  def clear_pressed(button)
    @label.text = "0"
    @brain.operand_stack = []
  end

end