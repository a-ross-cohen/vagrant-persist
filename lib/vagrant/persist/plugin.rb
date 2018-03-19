module Vagrant
  module Persist
    class Plugin < Vagrant.plugin(2)
      
      name 'vagrant-persist'
      description 'persist vagrant machine storage across instantiations'
      
      provisioner :persist do
        require_relative 'provisioner'
        Vagrant::Persist::Provisioner
      end
      
      config :persist, :provisioner do
        require_relative 'config'
        Vagrant::Persist::Config
      end
      
    end
  end
end