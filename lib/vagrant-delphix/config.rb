
module VagrantPlugins

  module Delphix

    class Config < Vagrant.plugin('2', :config)
      
      attr_accessor :enabled
      
      # engine access
      attr_accessor :engine_url
      attr_accessor :engine_user
      attr_accessor :engine_password
      
      # env definition
      attr_accessor :env_name
      attr_accessor :env_ip
      attr_accessor :user
      attr_accessor :password
      attr_accessor :toolkit_path
      attr_accessor :staging
      
      def initialize
        @enabled          = UNSET_VALUE
        @engine_url       = UNSET_VALUE
        @engine_user      = UNSET_VALUE
        @engine_password  = UNSET_VALUE
        @env_name         = UNSET_VALUE
        @env_ip           = UNSET_VALUE
        @user             = UNSET_VALUE
        @password         = UNSET_VALUE
        @toolkit_path     = UNSET_VALUE
        @staging          = UNSET_VALUE
      end

      def finalize!
        @enabled          = false if @enabled == UNSET_VALUE
        @engine_url       = nil if @engine_url == UNSET_VALUE
        @engine_user      = nil if @engine_user == UNSET_VALUE
        @engine_password  = nil if @engine_password == UNSET_VALUE
        @env_name         = nil if @env_name == UNSET_VALUE
        @env_ip           = nil if @env_ip == UNSET_VALUE
        @user             = nil if @user == UNSET_VALUE
        @password         = nil if @password == UNSET_VALUE
        @toolkit_path     = nil if @toolkit_path == UNSET_VALUE
        @staging          = false if @staging == UNSET_VALUE
      end

      def validate(machine)

        errors = []
        errors << validate_bool('delphix.enabled', @enabled)
        
        if @enabled
          
          # check if all values are present and of the correct type
          
          if machine.config.delphix.staging.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.staging',
            })
          else
            v = validate_bool('delphix.staging', machine.config.delphix.staging)
            errors << v if v != nil
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
            if !machine.config.delphix.password.nil? &&
               !machine.config.delphix.password.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.password',
                :is_class   => password.class.to_s,
              })
            end
          end
          
          if machine.config.delphix.toolkit_path.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.toolkit_path',
            })
          else
            if !machine.config.delphix.toolkit_path.nil? &&
               !machine.config.delphix.toolkit_path.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.toolkit_path',
                :is_class   => toolkit_path.class.to_s,
              })
            end
          end
          
          if machine.config.delphix.env_name.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.env_name',
            })
          else
            if !machine.config.delphix.env_name.nil? &&
               !machine.config.delphix.env_name.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.env_name',
                :is_class   => env_name.class.to_s,
              })
            end
          end
          
          if machine.config.delphix.env_ip.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.env_ip',
            })
          else
            if !machine.config.delphix.env_ip.nil? &&
               !machine.config.delphix.env_ip.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.env_ip',
                :is_class   => env_ip.class.to_s,
              })
            end
          end
          
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
          
          if machine.config.delphix.engine_user.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.engine_user',
            })
          else
            if !machine.config.delphix.engine_user.nil? &&
               !machine.config.delphix.engine_user.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.engine_user',
                :is_class   => engine_user.class.to_s,
              })
            end
          end
          
          if machine.config.delphix.engine_password.nil?
            errors << I18n.t('vagrant_delphix.config.not_defined', {
              :config_key => 'delphix.engine_password',
            })
          else
            if !machine.config.delphix.engine_password.kind_of?(String)
              errors << I18n.t('vagrant_delphix.config.not_a_string', {
                :config_key => 'delphix.engine_password',
                :is_class   => engine_password.class.to_s,
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
      
    end # class Config
    
  end # module Delphix
  
end # module VagrantPlugins
