'''
NOTICE

This software was produced for the U. S. Government
under Basic Contract No. W15P7T-13-C-A802, and is
subject to the Rights in Noncommercial Computer Software
and Noncommercial Computer Software Documentation
Clause 252.227-7014 (FEB 2012)

 2016 The MITRE Corporation. All Rights Reserved.
'''
# -*- mode: ruby -*-
# vi: set ft=ruby :



# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
 
  config.vm.box = "win7"
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.boot_timeout = 1000
  config.vm.network "private_network", ip: "10.0.2.15"
  # Prompt the user to accept the EULA if they haven't already
  if not File.exist?("#{File.dirname(__FILE__)}/.vagrant/accept_eula.txt")
    print "In order to continue you need to have read the current Sysinternals Software License Terms, and the current NXLOG PUBLIC LICENSE, and agree to be bound by the terms and conditions therein. Do you agree [Y/n]: "
    accept_eula = STDIN.gets.chomp
    if not accept_eula.downcase.start_with?("n")
      # if they accept the EULA write out the text file that gets checked for above
      File.write("#{File.dirname(__FILE__)}/.vagrant/accept_eula.txt", 'Placeholder indicating user accepted 3rd party EULA.')
    else
      raise Vagrant::Errors::VagrantError.new, "You need to accept the EULA in order to continue"
    end
  end
  
  # Download NxLog and Sysmon to the guest
  config.vm.provision :shell, path:  "scripts/download-files.ps1"

  # Provision NxLog and Sysmon
  config.vm.provision :shell, path: "scripts/install-nxlog.cmd"
  config.vm.provision :shell, path: "scripts/install-sysmon.cmd"
  config.vm.provision :shell, path: "scripts/copy-nxlog-conf.cmd"
  config.vm.provision :shell, path: "scripts/start-nxlog.cmd"
  

  config.vm.provision :shell, inline: "tzutil /s UTC"

  # rdp forward
  config.vm.network "forwarded_port", guest: 3389, host: 3389, id: "rdp", auto_correct: true
  
  # winrm config, uses modern.ie default user/password. If other credentials are used must be changed here
  config.winrm.username = "IEUser"
  config.winrm.password = "Passw0rd!"
  
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      vb.name = "unfetter_windows"
  #   # Customize the amount of memory on the VM:
     #vb.cpus = 1
     #vb.memory = 2048
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--vram", "128"]
      vb.customize ["modifyvm", :id,  "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  


  end

end
