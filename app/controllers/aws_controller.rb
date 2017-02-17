class AwsController < ApplicationController

  def show
    @regions = AWS::EC2.new.regions.to_a
  end

  def start_ec2
    binding.pry
  end

end
