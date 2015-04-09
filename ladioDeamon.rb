#!/usr/bin/env ruby

def mkladio(path)
  return if FileTest.exist?(path);
  parent = File::dirname(path);
  mkladio(parent);
  Dir::mkdir(path);
end
 
mount = ARGV[0]
dir = Dir.home + "/ladio/" + mount
mkladio(dir)
LOCKFILE = dir + "/.lock_file"

def file_check

   if File.exist?(LOCKFILE)
      pid = 0
      File.open(LOCKFILE, "r"){|f|
         pid = f.read.chomp!.to_i
      }
      if exist_process(pid)
         exit
      else
         p "please remove "+dir+"/.lock_file"
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
