config_file = "#{RAILS_ROOT}/config/s3_backup_config.yml"
if FileTest.exists?(config_file)
  S3_CONFIG = YAML.load_file(config_file)
else
  raise "Can't find s3_backup_config.yml"
end