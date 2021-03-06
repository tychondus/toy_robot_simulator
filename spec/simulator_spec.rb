require 'robot_simulator'
require 'board'
require 'robot'

RSpec.describe RobotSimulator, "#check" do
  context "both the Board and Robot class exists" do
    it "create Board and Robot class ensure they are not nil" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.board).to be_kind_of(Board)
      expect(rob_sim.robot).to be_kind_of(Robot)
    end
  end

  context "place method is able to place the robot in a valid location" do
    it "valid x and y values" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(2,2,'E')
      expect(rob_sim.is_placed).to eq true
      expect(rob_sim.robot.loc_x).to eq 2
      expect(rob_sim.robot.loc_y).to eq 2
      expect(rob_sim.robot.direction).to eq 'E'
    end
  end

  context "place method rejects values that are not valid and does not place the robot" do
    it "invalid x and/or y values" do
      #invalid x value
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(6,2,'E')
      expect(rob_sim.is_placed).to_not eq true
      expect(rob_sim.robot.loc_x).to_not eq 6
      expect(rob_sim.robot.loc_y).to_not eq 2
      expect(rob_sim.robot.direction).to_not eq 'E'

      #invalid y value
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(2,6,'E')
      expect(rob_sim.is_placed).to_not eq true
      expect(rob_sim.robot.loc_x).to_not eq 2
      expect(rob_sim.robot.loc_y).to_not eq 6
      expect(rob_sim.robot.direction).to_not eq 'E'

      #invalid direction
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(2,2,'T')
      expect(rob_sim.is_placed).to_not eq true
      expect(rob_sim.robot.loc_x).to_not eq 2
      expect(rob_sim.robot.loc_y).to_not eq 2
      expect(rob_sim.robot.direction).to_not eq 'T'
    end
  end

  context "left method is able to rotate the robot left by 90 degrees (only if the robot is placed)" do
    it "call rotate_left method found in Robot class" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      expect(rob_sim.robot.direction).to eq 'N'
      rob_sim.left
      expect(rob_sim.robot.direction).to eq 'N'
      rob_sim.place(2,2,'E')  
      expect(rob_sim.is_placed).to eq true
      rob_sim.left
      expect(rob_sim.robot.direction).to eq 'N'
    end
  end

  context "right method is able to rotate the robot right by 90 degrees (only if the robot is placed)" do
    it "call rotate_right method found in Robot class" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      expect(rob_sim.robot.direction).to eq 'N'
      rob_sim.right
      expect(rob_sim.robot.direction).to eq 'N'
      rob_sim.place(2,2,'W')  
      expect(rob_sim.is_placed).to eq true
      rob_sim.right
      expect(rob_sim.robot.direction).to eq 'N'
    end
  end

  context "that move command does not violate the board boundary (+x)" do
    it "move the robot 1 unit to the right and ensure that the robot does not fall" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(4,4,'E')
      expect(rob_sim.is_placed).to eq true
      expect(rob_sim.robot.loc_x).to eq 4
      expect(rob_sim.robot.loc_y).to eq 4
      expect(rob_sim.robot.direction).to eq 'E'
      rob_sim.move
      expect(rob_sim.robot.loc_x).to eq 4
      expect(rob_sim.robot.loc_y).to eq 4
      expect(rob_sim.robot.direction).to eq 'E'
    end
  end

  context "that move command does not violate the board boundary (-x)" do
    it "move the robot 1 unit to the left and ensure that the robot does not fall" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(0,0,'W')
      expect(rob_sim.is_placed).to eq true
      expect(rob_sim.robot.loc_x).to eq 0
      expect(rob_sim.robot.loc_y).to eq 0
      expect(rob_sim.robot.direction).to eq 'W'
      rob_sim.move
      expect(rob_sim.robot.loc_x).to eq 0
      expect(rob_sim.robot.loc_y).to eq 0
      expect(rob_sim.robot.direction).to eq 'W'
    end
  end

  context "that move command does not violate the board boundary (+y)" do
    it "move the robot 1 unit to the up and ensure that the robot does not fall" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(4,4,'N')
      expect(rob_sim.is_placed).to eq true
      expect(rob_sim.robot.loc_x).to eq 4
      expect(rob_sim.robot.loc_y).to eq 4
      expect(rob_sim.robot.direction).to eq 'N'
      rob_sim.move
      expect(rob_sim.robot.loc_x).to eq 4
      expect(rob_sim.robot.loc_y).to eq 4
      expect(rob_sim.robot.direction).to eq 'N'
    end
  end

  context "that move command does not violate the board boundary (-y)" do
    it "move the robot 1 unit to the down and ensure that the robot does not fall" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      rob_sim.place(0,0,'S')
      expect(rob_sim.is_placed).to eq true
      expect(rob_sim.robot.loc_x).to eq 0
      expect(rob_sim.robot.loc_y).to eq 0
      expect(rob_sim.robot.direction).to eq 'S'
      rob_sim.move
      expect(rob_sim.robot.loc_x).to eq 0
      expect(rob_sim.robot.loc_y).to eq 0
      expect(rob_sim.robot.direction).to eq 'S'
    end
  end

  context "that report is only generated if the robot is placed on the board" do
    it "return nil if robot is not place. If placed return a hash with keys x,y,direction containing the appropriate values" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      report_hash = rob_sim.report
      expect(report_hash).to eq nil
      rob_sim.place(0,0,'N')
      report_hash = rob_sim.report
      expect(report_hash).to_not eq nil 
      expect(report_hash['x']).to eq 0
      expect(report_hash['y']).to eq 0
      expect(report_hash['direction']).to eq 'N'
    end
  end
end
