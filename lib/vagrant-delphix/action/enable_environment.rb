
require 'delphix'
require 'vagrant-delphix/util'

module VagrantPlugins
  module DelphixEngine
    module Action

      class EnableEnvironment
        include VagrantPlugins::DelphixEngine::Util

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @global_env = @machine.env
          @provider = @machine.provider_name
          @logger = Log4r::Logger.new('vagrant::delphix_engine::create_environment')

          @config = get_config(@machine)
        end

        def call(env)
          # skip if plugin is not active on destroy action
          return @app.call(env) if !@config.enabled

          # set the DE url
          Delphix.url = @config.engine_url
          Delphix.debug = @config.trace

          # authenticate the connection
          Delphix.authenticate!(@config.engine_user,@config.engine_password)

          # lookup the environment
          environments = Delphix::Environment.list
          environment = environments.lookup_by_name @config.env_name

          # delete the environment from Delphix
          environment.enable if environment != nil

          @app.call(env)
        end

      end # end class

    end
  end
end
