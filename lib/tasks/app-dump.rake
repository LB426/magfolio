require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

@home = `echo $HOME`
@date = Time.now.strftime("%Y-%m-%d_%H:%M")
@mysqldump = `which mysqldump`
@bzip2 = `which bzip2`
@tar = `which tar`
@scp = `which scp`
@assets = "/home/magfolio/magfolio/shared/assets"
@home.chomp!
@date.chomp!
@mysqldump.chomp!
@bzip2.chomp!
@tar.chomp!
@assets.chomp!
@scp.chomp!
@db_archive_name = ""
@assets_archive_name = ""

system("mkdir -p #{@home}/backup")

namespace :dump do
  desc "Make database and assets on servers"
  task :all do |t, args|
    @db_archive_name = dump_database
    @assets_archive_name = dump_assets
  end
  desc "Make dump on server, download dump on localhost and restore database and assets"
  task :risefromremote do |t, args|
    puts Time.now
    system("ssh magfolio@tih.kuban.ru 'mysqldump -uroot -P3306 -h127.0.0.1 -p9002sliarNOiburLQSyM magfolio_production | bzip2 -c --best > /home/magfolio/backup/db_magfolio_production#{@date}.bz2'")
    system("ssh magfolio@tih.kuban.ru 'cd /home/magfolio/magfolio/shared/assets ; tar cf - . | bzip2 -c --best > /home/magfolio/backup/assets_magfolio#{@date}.tar.bz2'")
    system("scp magfolio@tih.kuban.ru:/home/magfolio/backup/db_magfolio_production#{@date}.bz2 /tmp/db_magfolio_production#{@date}.bz2")
    system("scp magfolio@tih.kuban.ru:/home/magfolio/backup/assets_magfolio#{@date}.tar.bz2 /tmp/assets_magfolio#{@date}.tar.bz2")
    system("mysqldump -uroot -P3306 -h127.0.0.1 magfolio_production | bzip2 -c --best > /Users/bliz/backup/db_magfolio_production#{@date}.bz2")
    system("cd /Users/bliz/Desktop/proj/magfolio/public/assets ; tar cf - . | bzip2 -c --best > /Users/bliz/backup/assets_magfolio#{@date}.tar.bz2")
    system("rm -rf /Users/bliz/Desktop/proj/magfolio/public/assets")
    system("mkdir -p /Users/bliz/Desktop/proj/magfolio/public/assets")
    system("bunzip2 /tmp/assets_magfolio#{@date}.tar.bz2")
    system("mv '/tmp/assets_magfolio#{@date}.tar' /Users/bliz/Desktop/proj/magfolio/public/assets/assets.tar")
    system("cd /Users/bliz/Desktop/proj/magfolio/public/assets ; tar -xf /Users/bliz/Desktop/proj/magfolio/public/assets/assets.tar")
    system("rm /Users/bliz/Desktop/proj/magfolio/public/assets/assets.tar")
    system("bunzip2 /tmp/db_magfolio_production#{@date}.bz2")
    system("mysql -uroot -P3306 -h127.0.0.1 magfolio_production < '/tmp/db_magfolio_production#{@date}'")
    system("mysql -uroot -P3306 -h127.0.0.1 magfolio_development < '/tmp/db_magfolio_production#{@date}'")
    system("rm /tmp/db_magfolio_production#{@date}")
    puts Time.now
  end
end

def dump_database
  command = "#{@mysqldump} -uroot -P3306 -h127.0.0.1 -p9002sliarNOiburLQSyM magfolio_production | #{@bzip2} -c --best > #{@home}/backup/db_magfolio_production#{@date}.bz2"
  puts command
  system("#{command}")
  return "#{@home}/backup/db_magfolio_production#{@date}.bz2"
end

def dump_assets
  command = "#{@tar} cf - #{@assets} | #{@bzip2} -c --best > #{@home}/backup/assets_magfolio#{@date}.bz2"
  puts command
  system("#{command}")
  return "#{@home}/backup/assets_magfolio#{@date}.bz2"
end
