require 'find'
require 'ftools'
require 'aws/s3'

namespace :assets do
  desc "Backup everything in the public folder." 
  task :backup => [:environment] do
    AWS::S3::Base.establish_connection!(:access_key_id => APP_CONFIG['access_key_id'], :secret_access_key => APP_CONFIG['secret_access_key'])
    BUCKET = APP_CONFIG['bucket']

    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    base_path = ENV["RAILS_ROOT"] || "." 
    file_name = "assets-#{datestamp}.tgz" 
    backup_file = File.join(base_path, "tmp", file_name)
    sh "tar -cvzpf #{backup_file} public"
    AWS::S3::S3Object.store(file_name, open(backup_file), BUCKET)
    puts "Created backup: #{file_name}" 
    FileUtils.rm_rf(backup_file)

    bucket = AWS::S3::Bucket.find(BUCKET)
    all_backups = bucket.objects.select { |f| f.key.match(/assets/) }.sort { |a,b| a.key <=> b.key }.reverse
    max_backups = APP_CONFIG['asset_backups_to_keep'].to_i || 28
    unwanted_backups = all_backups[max_backups..-1] || []
    for unwanted_backup in unwanted_backups
      unwanted_backup.delete
      puts "deleted #{unwanted_backup.key}" 
    end
    puts "Deleted #{unwanted_backups.length} backups, #{all_backups.length - unwanted_backups.length} backups available" 
  end
end