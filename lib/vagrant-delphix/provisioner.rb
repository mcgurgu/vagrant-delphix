
require 'delphix'

module VagrantPlugins
  module Delphix

    class Provisioner < Vagrant.plugin('2', :provisioner)

      def initialize(machine, config)
        super(machine, config)
        
        @config = get_config(machine)
        
        #puts "--- #{machine.name}"
        #puts "--- #{machine.provider_name}"
        
        #puts "--- #{machine.config.vm.hostname}"
        #puts "IP #{ip = machine.provider.capability(:public_address)}"
      end

      def provision
        # set the DE url
        Delphix.url = @config.engine_url
        Delphix.debug = @config.trace

        # authenticate the connection
        Delphix.authenticate!(@config.engine_user,@config.engine_password)

        # ceate a new environment
        #env = Delphix::Environment.create 'PRODUCTION', '172.16.138.101', 22, '/opt/toolkitp', 'postgres', 'postgres'
        
        puts "---1 #{@config.user}"
        puts "---2 #{@config.password}"
        puts "---3 #{@config.toolkit_path}"
        puts "---4 #{@config.engine_user}"
        puts "---5 #{@config.engine_password}"
        puts "---6 #{@config.engine_url}"
      end
      
      private
      
      def get_config(machine)
        config = machine.config.delphix
        config.merge(machine.env.vagrantfile.config.delphix)
        config
      end
      
    end # end Class
    
  end
end
