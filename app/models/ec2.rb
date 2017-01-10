require 'socket'
require 'net/ssh'

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

  puts "Launched: You can SSH to it with;"
  puts "ssh -i #{private_key_file} #{ssh_username}@#{instance.public_dns_name}"
  puts "Remember to terminate after you are done!"

  sleep 40

  # Updates apt-get files on the Ubuntu instance
  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file ) do |ssh|
    ssh.exec "sudo apt-get update && sudo apt-get -y upgrade"
    ssh.loop
  end

  # Install rvm and rails environments
  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file ) do |ssh|
    ssh.exec "sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
    ssh.exec "sudo curl -sSL https://get.rvm.io | sudo bash -s stable --rails"
    ssh.loop
  end

  # Add user to rvm environment; install bundler, install nodejs
  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file ) do |ssh|
    ssh.exec "sudo usermod -a -G rvm ubuntu"
    ssh.exec "gem install bundler --no-rdoc --no-ri"
    ssh.exec "sudo apt-get install -y nodejs"
    ssh.exec "sudo ln -sf /usr/bin/nodejs /usr/local/bin/node"
    ssh.loop
  end

  # install nginx and passenger services for ubuntu xenial
  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file ) do |ssh|
    ssh.exec "sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7"
    ssh.exec "sudo apt-get install -y apt-transport-https ca-certificates"
    ssh.exec "sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'"
    ssh.exec "sudo apt-get update"
    ssh.loop
  end

  # install niginx passenger and prepend nginx.conf to include the passenger service; restart nginx
  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file ) do |ssh|
    ssh.exec "sudo apt-get install -y nginx-extras passenger"
    ssh.exec "sudo sed -i '/passenger.conf/s/#//g' /etc/nginx/nginx.conf"
    ssh.exec "sudo service nginx restart"
    ssh.loop
  end

  # update and upgrade install services
  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file ) do |ssh|
    ssh.exec "sudo apt-get update"
    ssh.exec "sudo apt-get upgrade"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file ) do |ssh|
    ssh.exec "sudo mkdir -p ~ubuntu/.ssh"
    ssh.exec "touch $HOME/.ssh/authorized_keys"
    ssh.exec "sudo sh -c 'cat $HOME/.ssh/authorized_keys >> ~ubuntu/.ssh/authorized_keys'"
    ssh.exec "sudo sh -c 'chmod 600 ~ubuntu/.ssh/*'"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "rvm use ruby-2.3.3"
    ssh.exec "sudo apt-get install -y git"
    ssh.exec "sudo mkdir -p /var/www/myapp"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "sudo chown ubuntu: /var/www/myapp && cd /var/www/myapp && sudo -u ubuntu -H git clone https://github.com/NZenitram/spamgrid.git"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "sudo gem install bundler"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "sudo apt-get install -y ruby-dev"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "sudo apt-get install -y libpq-dev"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "sudo apt-get install -y postgresql"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "cd /var/www/myapp/spamgrid && sudo bundle install --deployment --without development test"
    ssh.loop
  end

  Net::SSH.start(instance.public_dns_name, ssh_username, :keys => private_key_file) do |ssh|
    ssh.exec "cd /var/www/myapp/spamgrid && bundle exec rake assets:precompile"
    ssh.exec "sudo -u postgres createuser --superuser ubuntu"
    ssh.loop
  end

  puts "ssh -i #{private_key_file} #{ssh_username}@#{instance.public_dns_name}"
  # Don't forget to shut down the server with:

  # instance.delete


end
