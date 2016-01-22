
require 'vagrant-delphix/action/create_environment'
require 'vagrant-delphix/action/disable_environment'
require 'vagrant-delphix/action/destroy_environment'

module VagrantPlugins
  module Delphix
    module Action
      include Vagrant::Action::Builtin

      def self.create_environment
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use ConfigValidate
          builder.use CreateEnvironment
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
      
    end
  end
end
