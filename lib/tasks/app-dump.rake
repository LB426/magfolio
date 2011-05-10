require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

@home = `echo $HOME`
@date = Time.now.strftime("%Y-%m-%d:%H:%M")
@mysqldump = `which mysqldump`
@bzip2 = `which bzip2`
@tar = `which tar`
@assets = "/home/magfolio/magfolio/shared/assets"
@home.chomp!
@date.chomp!
@mysqldump.chomp!
@bzip2.chomp!
@tar.chomp!
@assets.chomp!

system("mkdir -p #{@home}/backup")

namespace :dump do
  desc "Создание дампа базы данных и assets-ов"
  task :all do |t, args|
    #host = Rails.configuration.database_configuration[Rails.env]["host"]
    #port = Rails.configuration.database_configuration[Rails.env]["port"]
    #user = Rails.configuration.database_configuration[Rails.env]["username"]
    #pass = Rails.configuration.database_configuration[Rails.env]["password"]
    #db = Rails.configuration.database_configuration[Rails.env]["database"]
    #puts @home
    #puts "#{@date}"
    dump_database
    dump_assets
  end
end

def dump_database
  command = "#{@mysqldump} -uroot -P3306 -h127.0.0.1 -p9002sliarNOiburLQSyM magfolio_production| #{@bzip2} -c --best > #{@home}/backup/db_magfolio_production#{@date}.bz2"
  puts command
  system("#{command}")
end

def dump_assets
  caomman = "#{@tar} cf - #{@assets} | #{@bzip2} -c --best > #{@home}/backup/assets_magfolio#{@date}.bz2"
  puts command
  system("#{command}")
end