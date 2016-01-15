
module VagrantPlugins
  module Delphix

    class Provisioner < Vagrant.plugin('2', :provisioner)

      def initialize(machine, config)
        super(machine, config)
        
        @config = machine.env.vagrantfile.config.delphix
    
      end

      def provision
        puts "+++ PROVISION +++"
        puts "--- #{@config.engine_url}"
      end
      
    end # end Class
    
  end
end
