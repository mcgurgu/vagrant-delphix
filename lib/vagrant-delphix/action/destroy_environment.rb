
require 'delphix'
require 'vagrant-delphix/util'

module VagrantPlugins
  module DelphixEngine
    module Action

      class DestroyEnvironment
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
          environment = Delphix::Environment.list.lookup_by_name @config.env_name

          # Delete the environment and all its sources. Blocks until completion or error.
          environment.delete.wait_for_completion if environment != nil

          @app.call(env)
        end

      end # end class

    end
  end
end
