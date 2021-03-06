require 'robot_simulator'
require 'board'
require 'robot'

RSpec.describe RobotSimulator, "#check" do
 context "Example A" do
    it "Example A" do
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
      rob_sim.move
      report_hash = rob_sim.report
      expect(report_hash['x']).to eq 0
      expect(report_hash['y']).to eq 1
      expect(report_hash['direction']).to eq 'N'
    end
  end

  context "Example B" do
    it "Example B" do
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
      rob_sim.left
      report_hash = rob_sim.report
      expect(report_hash['x']).to eq 0
      expect(report_hash['y']).to eq 0
      expect(report_hash['direction']).to eq 'W'
    end
  end

  context "Example C" do
    it "Example C" do
      rob_sim = RobotSimulator.new
      expect(rob_sim.is_placed).to eq false
      report_hash = rob_sim.report
      expect(report_hash).to eq nil
      rob_sim.place(1,2,'E')
      report_hash = rob_sim.report
      expect(report_hash).to_not eq nil 
      expect(report_hash['x']).to eq 1
      expect(report_hash['y']).to eq 2
      expect(report_hash['direction']).to eq 'E'
      rob_sim.move
      rob_sim.move
      rob_sim.left
      rob_sim.move
      report_hash = rob_sim.report
      expect(report_hash['x']).to eq 3
      expect(report_hash['y']).to eq 3
      expect(report_hash['direction']).to eq 'N'
    end
  end
end
