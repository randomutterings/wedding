config_file = "#{RAILS_ROOT}/config/config.yml"
if FileTest.exists?(config_file)
  APP_CONFIG = YAML.load_file(config_file)
else
  raise "Can't find config.yml"
end