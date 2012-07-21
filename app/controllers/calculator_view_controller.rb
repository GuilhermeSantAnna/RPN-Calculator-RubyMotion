class CalculatorViewController < UIViewController

  def loadView
    self.view = UIView.alloc.init
    self.view.backgroundColor = UIColor.whiteColor
  end

  def viewDidLoad
    # label for display
    @label = makeLabel
    view.addSubview(@label)

    # calc buttons
    view.addSubview(makeButton(title: "7", x: 20,  y: 60))
    view.addSubview(makeButton(title: "8", x: 94,  y: 60))
    view.addSubview(makeButton(title: "9", x: 168, y: 60))
    view.addSubview(makeButton(title: "*", x: 242, y: 60))
    view.addSubview(makeButton(title: "4", x: 20,  y: 107))
    view.addSubview(makeButton(title: "5", x: 94,  y: 107))
    view.addSubview(makeButton(title: "6", x: 168, y: 107))
    view.addSubview(makeButton(title: "/", x: 242, y: 107))
    view.addSubview(makeButton(title: "1", x: 20,  y: 154))
    view.addSubview(makeButton(title: "2", x: 94,  y: 154))
    view.addSubview(makeButton(title: "3", x: 168, y: 154))
    view.addSubview(makeButton(title: "+", x: 242, y: 154))
    view.addSubview(makeButton(title: "C", x: 20,  y: 201))
    view.addSubview(makeButton(title: "0", x: 94,  y: 201))
    view.addSubview(makeButton(title: "Enter", x: 168,  y: 201))
    view.addSubview(makeButton(title: "-", x: 242,  y: 201))
  end

  def makeLabel
    label = UILabel.alloc.initWithFrame([[10,20], [300,30]])
    label.text = "10"
    label.textAlignment = UITextAlignmentRight
    label.font = UIFont.boldSystemFontOfSize(20)
    label
  end

  def makeButton(options = {})
    options[:title] = "title" unless options[:title]
    options[:x] = 20 unless options[:x]
    options[:y] = 60 unless options[:y]

    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.frame = CGRectMake(options[:x], options[:y], 64, 37)
    button.setTitle(options[:title], forState:UIControlStateNormal)
    button.addTarget(self, action: :'digit_pressed', forControlEvents:UIControlEventTouchUpInside)
    button
  end

  def digit_pressed
    @calculator_brain = CalculatorBrain.alloc.init
    @calculator_brain.push_operand("+")

    @label.text = "results"
  end

end