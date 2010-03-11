config_file = "#{RAILS_ROOT}/config/config.yml"
APP_CONFIG = YAML.load_file(config_file) if FileTest.exists?(config_file)