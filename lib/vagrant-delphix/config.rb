module VagrantPlugins
  module Delphix
    class Config < Vagrant.plugin('2', :config)
      
      attr_accessor :enabled
      
      attr_accessor :engine_url
      attr_accessor :user
      attr_accessor :password
      
      def initialize
        @enabled    = UNSET_VALUE
        @engine_url = UNSET_VALUE
        @user       = UNSET_VALUE
        @password   = UNSET_VALUE
      end

      def finalize!
        @enabled    = false if @enabled == UNSET_VALUE
        @engine_url = nil if @engine_url == UNSET_VALUE
        @user       = nil if @user == UNSET_VALUE
        @password   = nil if @password == UNSET_VALUE
      end

      def validate(machine)

        errors = []
        errors << validate_bool('delphix.enabled', @enabled)
        
        if @enabled
          # check if all values are present
          if machine.config.delphix.engine_url.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.engine_url',
            })
          else
            if !machine.config.delphix.engine_url.nil? &&
               !machine.config.delphix.engine_url.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.engine_url',
                :is_class   => engine_url.class.to_s,
              })
            end
          end
          
          if machine.config.delphix.user.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.user',
            })
          else
            if !machine.config.delphix.user.nil? &&
               !machine.config.delphix.user.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.user',
                :is_class   => user.class.to_s,
              })
            end
          end
          
          if machine.config.delphix.password.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.password',
            })
          else
            if !machine.config.delphix.password.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.password',
                :is_class   => password.class.to_s,
              })
            end
          end
                  
        end
        
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
