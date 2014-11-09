#### Question 1
# Replace the comment below with a single line of code that will set the
# robot's online status to `true` and correctly output the debugging string.

class Robot
  def online=(value)
    debug_output("online status: #{value}")
    @online = value
  end

  def activate
    self.online = true
    online=(true)
    self.online=(true)
  end
end
##-Wrong (1)
##-online = true does not call the setter for the variable in the class.
##-@online = true changes the variable but doesn't go through the method and so the debug doesn't output correctly


#### Question 2
# Given the following class, write code that would create a single robot and
# deactivate it. Then write code that would deactivate all robots. Do not change
# the class definition -- assume the methods do what they say.

class Robot
  def deactivate
    # ...
    self.class.deactivate_all
  end

  def self.deactivate_all
    # ...
  end
end
ironman = Robot.new.deactivate # This is right
Robot.deactivate_all # This is right

Robot.self.deactivate_all # Wrong (2)


# Here, self is main, so this is not correct
self.deactivate_all

#### Question 3
# Write a module called `Speech` and add an instance method called `say` to it
# (no code needed in this method). Then add code to the Human and Robot classes
# that will allow them to use the `say` method.

# This is right
module Speech
  def say(string)
  end

  def self.foobar
  end
end

Speech.foobar # This works
Speech.say # This does not work

class Human
  include Speech # This is right
  def chat
    say('How about that weather?')
  end
end

class Robot
  include Speech # This is right
  def chat
    say('Small talk program not installed.')
  end
end


#### Question 4
# Replace the comment below with code that will raise a Robot::ImmobileError
# when `move` is called on a robot that has no legs and no wheels.

class Robot
  class ImmobileError < StandardError; end

  def initialize(legs: 0, wheels: 0)
    @legs, @wheels = legs, wheels
  end

  def move(target)
    # This is wrong. @legs and @wheels, not target.legs or target.wheels
    #raise Robot::ImmobileError if target.legs < 1 && target.wheels < 1

    # Robot:: not necessary as we are already within the Robot class
    # :: refer to a nested class / module
    raise ImmobileError if @legs == 0 && @wheels == 0 # This is the solution

  end
end


#### Question 5
# Modify the `qualified?` method below so that it returns `true` if the robot
# passed into it can move and `false` otherwise. Assume the `move` method will
# raise a Robot::ImmobileError if the robot cannot move.

ironman = Robot.new(0, 1)
class RobotRace
  def qualified?(robot)
    begin
      robot.move
      true
    rescue Robot::ImmobileError
      false
    end
  end
end

qualified?(ironman)+

# This is right but I got it wrong (4)

#### Bonus Question
# Copy and paste the classes from questions 4 and 5 here, then modify them so
# the qualification check can be done without having to rescue an error. In the
# real world this approach is preferred, if we have control over both classes.

class Robot
  class ImmobileError < StandardError; end

  def initialize(legs: 0, wheels: 0)
    @legs, @wheels = legs, wheels
  end

  def move(target)
    raise ImmobileError if @legs == 0 && @wheels == 0 # This is the solution
  end
end

  def mobile?
    @legs > 0 || wheels > 0
  end
end

class RobotRace
  def qualified?(robot)
    robot.mobile?
  end
end
