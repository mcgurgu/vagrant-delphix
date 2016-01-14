
module VagrantPlugins
  module Delphix
    module Action
      class CreateEnvironment

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @global_env = @machine.env
          @provider = @machine.provider_name
          @logger = Log4r::Logger.new('vagrant::delphix::create_environment')
        end

        def call(env)
          # skip if machine is not active on destroy action
          return @app.call(env) if !@machine.id && env[:machine_action] == :destroy

          puts "+++ CREATE +++"
        end
        
      end # end class
      
    end
  end
end
