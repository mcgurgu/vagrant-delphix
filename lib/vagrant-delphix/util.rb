
module VagrantPlugins
  module DelphixEngine
    
    module Util
      
      def get_config(machine)
        config = machine.config.delphix
        config.merge(machine.env.vagrantfile.config.delphix)
        config
      end
      
    end
     
  end
end