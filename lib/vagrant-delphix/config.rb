module VagrantPlugins
  module Delphix
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :enabled
      attr_accessor :manage_environment
      attr_accessor :engine_url
      attr_accessor :engine_user
      attr_accessor :engine_password
      
      def initialize
        @enabled            = UNSET_VALUE
        @manage_environment = UNSET_VALUE
        @engine_url         = UNSET_VALUE
        @engine_user        = UNSET_VALUE
        @engine_password    = UNSET_VALUE
      end

      def finalize!
        @enabled            = false if @enabled == UNSET_VALUE
        @manage_environment = false if @manage_environment == UNSET_VALUE
        @engine_url         = false if @engine_url == UNSET_VALUE
        @engine_user        = false if @engine_user == UNSET_VALUE
        @engine_password    = false if @engine_password == UNSET_VALUE
      end

      def validate(machine)
        errors = []

        #errors << validate_bool('hostmanager.enabled', @enabled)
        
        errors.compact!
        { "Delphix configuration" => errors }
      end

      private

      def validate_bool(key, value)
        if ![TrueClass, FalseClass].include?(value.class) &&
           value != UNSET_VALUE
          I18n.t('vagrant_delphix.config.not_a_bool', {
            :config_key => key,
            :value      => value.class.to_s
          })
        else
          nil
        end
      end
    end
  end
end
