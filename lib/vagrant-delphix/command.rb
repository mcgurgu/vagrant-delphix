module VagrantPlugins
  module Delphix
    class Command < Vagrant.plugin('2', :command)

      # Show description when `vagrant list-commands` is triggered
      def self.synopsis
        "plugin: vagrant-delphix: bla bla"
      end

      def execute
        options = {}
        opts = OptionParser.new do |o|
          o.banner = 'Usage: vagrant delphix [vm-name]'
          o.separator ''
          o.version = VagrantPlugins::Delphix::VERSION
          o.program_name = 'vagrant delphix'

          o.on('--provider provider', String,
            'Update machines bla bla.') do |provider|
            options[:provider] = provider.to_sym
          end
        end

        argv = parse_options(opts)
        options[:provider] ||= @env.default_provider

        # do something
        
      end
    end
  end
end
