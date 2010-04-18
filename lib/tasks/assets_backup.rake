require 'find'
require 'ftools'
require 'aws/s3'

namespace :assets do
  desc "Backup everything in the public folder." 
  task :backup => [:environment] do
    AWS::S3::Base.establish_connection!(:access_key_id => S3_CONFIG['access_key_id'], :secret_access_key => S3_CONFIG['secret_access_key'])
    BUCKET = S3_CONFIG['bucket']

    datestamp = Time.now.strftime("%Y-%m-%d-%H-%M-%S")
    base_path = ENV["RAILS_ROOT"] || "." 
    file_name = "assets-#{datestamp}.tgz" 
    backup_file = File.join(base_path, "tmp", file_name)
    sh "tar -cvzpf #{backup_file} public"
    AWS::S3::S3Object.store(file_name, open(backup_file), BUCKET)
    puts "Created backup: #{file_name}" 
    FileUtils.rm_rf(backup_file)

    bucket = AWS::S3::Bucket.find(BUCKET)
    all_backups = bucket.objects.select { |f| f.key.match(/assets/) }.sort { |a,b| a.key <=> b.key }.reverse
    max_backups = S3_CONFIG['assets_backups_to_keep'].to_i || 28
    unwanted_backups = all_backups[max_backups..-1] || []
    for unwanted_backup in unwanted_backups
      unwanted_backup.delete
      puts "deleted #{unwanted_backup.key}" 
    end
    puts "Deleted #{unwanted_backups.length} backups, #{all_backups.length - unwanted_backups.length} backups available" 
  end
end

namespace :assets do
  desc "Restore the public folder from an available backup." 
  task :restore => [:environment] do
    base_path = ENV["RAILS_ROOT"] || "." 
    AWS::S3::Base.establish_connection!(:access_key_id => S3_CONFIG['access_key_id'], :secret_access_key => S3_CONFIG['secret_access_key'])
    bucket_name = S3_CONFIG['bucket']
    backups = AWS::S3::Bucket.objects(bucket_name)
    if backups.size == 0
      puts "no backups available, check your settings in config/s3_backup_config.yml"
    else
      puts "#{backups.size} backups are available..."
      counter = 0
      backups.each do |backup|
        puts "[#{counter}] #{backup.key}"
        counter += 1
      end
      if backups.size == 1
        puts "Which backup should we restore? [0]"
      else
        puts "Which backup should we restore? [0-#{backups.size - 1}]"
      end
      STDOUT.flush()
      selected = STDIN.gets.chomp.to_i
      if backups.at(selected).nil?
        puts "Backup not found, aborting"
      else
        file_name = backups.at(selected).key
        backup_file = File.join(base_path, file_name)
        destination = File.join(base_path, "public")
        puts "downloading backup..."
        open(backup_file, 'w') do |file|
          AWS::S3::S3Object.stream(file_name, bucket_name) do |chunk|
            file.write chunk
          end
        end
        FileUtils.remove_dir(destination)
        sh "tar zxfv #{backup_file}"
        puts "cleaning up..."
        FileUtils.rm_rf(backup_file)
        puts "Finished"
      end
    end
  end
end