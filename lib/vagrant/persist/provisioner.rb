module Vagrant
  module Persist
    class Provisioner < Vagrant.plugin(2, :provisioner)
      
      attr_reader :new_disk
      
      def configure(root_config)
        puts 'persist --> configure'
        if File.exists? config.path
          puts "persist --> #{config.path} found."
        else
          puts "persist --> #{config.path} does not exist, creating..."
          puts `VBoxManage createmedium disk --filename #{config.path} --format VDI --size #{config.size * 1024}`
          @new_disk = true
        end
        puts `VBoxManage storagectl #{machine.id} --name SATAController --portcount 2`
        puts 'persist <--'
      end

      def provision
        puts 'persist --> provision'
        puts 'persist --> attaching storage'
        puts `VBoxManage storageattach #{machine.id} --storagectl SATAController --port 1 --device 0 --type hdd --medium #{config.path}`
        sleep 1
        if new_disk
          puts 'persist --> new disk, formatting...'
          machine.communicate.execute 'echo y | sudo mkfs.ext4 /dev/sdb'
        end
        puts 'persist --> mounting...'
        machine.communicate.execute "sudo mkdir #{config.mount}"
        machine.communicate.execute "sudo mount /dev/sdb #{config.mount}"
        if new_disk && config.user
          machine.communicate.execute "sudo chown #{config.user} #{config.mount}"
        end
        puts 'persist <--'
      end
      
      def cleanup
        puts 'persist --> cleanup'
        puts 'persist --> detaching storage'
        machine.communicate.execute 'sudo umount /dev/sdb || true'
        puts `VBoxManage storageattach #{machine.id} --storagectl SATAController --port 1 --device 0 --type hdd --medium none`
        puts 'persist <--'
      end
      
    end
  end
end