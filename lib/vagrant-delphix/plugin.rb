require 'vagrant-delphix/action'

module VagrantPlugins
  module Delphix
    
    class Plugin < Vagrant.plugin('2')
      name 'HostManager'
      description <<-DESC
        This plugin manages Delphix Engine
      DESC

      config(:delphix) do
        require_relative 'config'
        Config
      end

      action_hook(:delphix, :machine_action_up) do |hook|
        hook.after(Vagrant::Action::Builtin::Provision, Action.create_environment)
      end

      action_hook(:delphix, :machine_action_halt) do |hook|
        hook.prepend(Action.disable_environment)
      end
      
      action_hook(:delphix, :machine_action_destroy) do |hook|
        hook.prepend(Action.destroy_environment)
      end

      provisioner(:delphix) do
        require_relative 'provisioner'
        Provisioner
      end

      # Work-around for vagrant >= 1.5
      # It breaks without a provisioner config, so we provide a dummy one
      config(:delphix, :provisioner) do
        puts "+++ C2"
        ::Vagrant::Config::V2::DummyConfig.new
      end

    end
  end
end
