namespace :config do
  task :environment do
    set :config_templates_path, "lib/capistrano/linked_files"
    set :config_path, "/opt/project/bookmark/shared/config"
  end

  desc "Unicorn config upload to server"
  task :setup => :environment do
    on roles(:all) do |host|
      if "#{fetch(:stage)}" == "production"
        upload! "#{fetch(:config_templates_path)}/database.yml" , "#{fetch(:config_path)}/database.yml"
      else
        upload! "#{fetch(:config_templates_path)}/database_staging.yml" , "#{fetch(:config_path)}/database.yml"
        upload! "#{fetch(:config_templates_path)}/config_staging.yml" , "#{fetch(:config_path)}/config.yml"
        upload! "#{fetch(:config_templates_path)}/carrierwave_staging.rb" , "/system/txdiag/shared/config/initializers/carrierwave.rb"
        upload! "#{fetch(:config_templates_path)}/redis_staging.rb" , "/system/txdiag/shared/config/initializers/redis.rb"
      end
    end
  end

end
