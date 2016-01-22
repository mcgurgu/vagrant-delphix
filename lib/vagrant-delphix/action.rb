
require 'vagrant-delphix/action/enable_environment'
require 'vagrant-delphix/action/disable_environment'
require 'vagrant-delphix/action/destroy_environment'

module VagrantPlugins
  module DelphixEngine
    
    module Action
      include Vagrant::Action::Builtin

      def self.enable_environment
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use EnableEnvironment
        end
      end
      
      def self.disable_environment
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use DisableEnvironment
        end
      end
      
      def self.destroy_environment
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use DestroyEnvironment
        end
      end
      
    end # end module Action
    
  end
end
