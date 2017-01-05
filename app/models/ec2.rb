require 'socket'
class Ec2 < ApplicationRecord

  AWS.config(access_key_id: ENV['AWS_ACCESS_KEY_ID'],
             secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])

  ec2                 = AWS::EC2.new.regions['us-west-1']
  ami_name            = '*ubuntu-xenial-16.04-amd64-server-20161020'
  key_pair_name       = 'MyEC2Key'
  private_key_file    = "#{ENV['HOME']}/Downloads/MyEC2Key.pem"
  security_group_name = 'launch-wizard-2'
  instance_type       = 't2.micro'
  ssh_username        = 'ubuntu'

  image = AWS.memoize do
    ec2.images.filter("root-device-type", "ebs").filter('name', ami_name).first
  end

  if image
    puts "Using AMI: #{image.id}"
  else
    raise "No image found matching #{ami_name}"
  end

  key_pair = ec2.key_pairs[key_pair_name]
  puts "Using keypair #{key_pair.name}, fingerprint: #{key_pair.fingerprint}"

  security_group = ec2.security_groups.find{|sg| sg.name == security_group_name }
  puts "Using security group: #{security_group.name}"

  instance = ec2.instances.create(:image_id        => image.id,
                                  :instance_type   => instance_type,
                                  :count           => 1,
                                  :security_groups => security_group,
                                  :key_pair        => key_pair)

  puts "Launching machine ..."

  sleep 1 until instance.status != :pending
  
  puts "Launched instance #{instance.id}, status: #{instance.status}, public dns: #{instance.dns_name}, public ip: #{instance.ip_address}"

  exit 1 unless instance.status == :running

  puts "Launched: You can SS to it with;"
  puts "ssh -i #{private_key_file} #{ssh_username}@#{instance.ip_address}"
  puts "Remember to terminate after you are done!"

  # Don't forget to shut down the server with:

  # instance.delete


end
