
require 'delphix'
require 'vagrant-delphix/util'

module VagrantPlugins
  module DelphixEngine

    class Provisioner < Vagrant.plugin('2', :provisioner)
      include VagrantPlugins::DelphixEngine::Util

      def initialize(machine, config)
        super(machine, config)
        @config = get_config(machine)
      end

      def provision

        # skip if plugin is not active on destroy action
        return if !@config.enabled

        # set the DE url
        Delphix.url = @config.engine_url
        Delphix.debug = @config.trace

        # authenticate the connection
        Delphix.authenticate!(@config.engine_user,@config.engine_password)

        # lookup the environment
        environments = Delphix::Environment.list
        environment = environments.lookup_by_name @config.env_name

        if environment == nil
          # ceate a new environment
          environment = Delphix::Environment.create @config.env_name, @config.env_ip, @config.env_port, @config.toolkit_path, @config.user, @config.password
        else
          # enable the environment
          environment.enable
        end

      end

    end # end Class

  end
end
