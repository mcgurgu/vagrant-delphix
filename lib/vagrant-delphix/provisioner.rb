
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
        environment = Delphix::Environment.list.lookup_by_name @config.env_name

        if environment == nil
          # Ceate a new environment. This call blocks until the environment is ready or there was an error.
          Delphix::Environment.create @config.env_name, @config.env_ip, @config.env_port, @config.toolkit_path, @config.user, @config.password
        else
          # enable the environment
          environment.enable
        end

      end

    end # end Class

  end
end
