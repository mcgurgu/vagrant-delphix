#require 'vagrant-hostmanager/hosts_file/updater'

module VagrantPlugins
  module Delphix
    class Provisioner < Vagrant.plugin('2', :provisioner)

      def initialize(machine, config)
        puts "+++ PROVISION.init +++"
        super(machine, config)
        global_env = machine.env
        @config = Util.get_config(global_env)
        #@updater = HostsFile::Updater.new(global_env, machine.provider_name)
      end

      def provision
        puts "+++ PROVISION +++"
        #@updater.update_guest(@machine)
        #if @config.hostmanager.manage_host?
        #  @updater.update_host
        #end
      end
    end
  end
end
