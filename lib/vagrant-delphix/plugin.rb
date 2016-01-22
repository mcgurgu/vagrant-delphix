
require 'delphix'
require 'vagrant-delphix/action'

module VagrantPlugins
  module DelphixEngine
    
    class Plugin < Vagrant.plugin('2')
      name 'DelphixEngine'
      description <<-DESC
        This plugin manages Delphix Engine
      DESC

      config(:delphix) do
        require_relative 'config'
        Config
      end

      #action_hook(:delphix, :machine_action_up) do |hook|
      #hook.after(Vagrant::Action::Builtin::Provision, Action.enable_environment)
      #end
      
      action_hook(:delphix, :machine_action_resume) do |hook|
        hook.after(Vagrant::Action::Builtin::Provision, Action.enable_environment)
      end
      
      action_hook(:delphix, :machine_action_halt) do |hook|
        hook.prepend(Action.disable_environment)
      end
      
      action_hook(:delphix, :machine_action_suspend) do |hook|
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
        ::Vagrant::Config::V2::DummyConfig.new
      end

    end # end class Plugin
    
  end
end
