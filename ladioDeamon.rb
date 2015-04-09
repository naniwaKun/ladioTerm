#!/usr/bin/env ruby
mount = ARGV[0]
dir = Dir.home + "/ladio/" + mount
FileUtils.mkdir_p dir 
LOCKFILE = dir + "/.lock_file"

def file_check

   if File.exist?(LOCKFILE)
      pid = 0
      File.open(LOCKFILE, "r"){|f|
         pid = f.read.chomp!.to_i
      }
      if exist_process(pid)
         print ("既に起動中のヤツがいるです")
         exit
      else
         print ("プロセス途中で死んでファイル残ったままっぽいっす")
         exit
      end
   else
      File.open(LOCKFILE, "w"){|f|
         locked = f.flock(File::LOCK_EX | File::LOCK_NB)
         if locked
            f.puts $$
         else
            $logger.error("lock failed -> pid: #{$$}")
         end
      }
   end
end

def exist_process(pid)
   begin
      gid = Process.getpgid(pid)
      return true
   rescue => ex
      puts ex
      return false
   end
end

file_check

sleep 60

File.delete(LOCKFILE)
