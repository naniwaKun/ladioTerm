#!/usr/bin/env ruby
mount = ARGV[0]
dir = Dir.home + "/ladio/" + mount
Dir::mkdir(dir)
LOCKFILE = dir + "/.lock_file"

def file_check
   # ファイルチェック
   if File.exist?(LOCKFILE)
      # pidのチェック
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
   # なければLOCKファイル作成
      File.open(LOCKFILE, "w"){|f|
         # LOCK_NBのフラグもつける。もしぶつかったとしてもすぐにやめさせる。
         locked = f.flock(File::LOCK_EX | File::LOCK_NB)
         if locked
            f.puts $$
         else
            $logger.error("lock failed -> pid: #{$$}")
         end
      }
   end
end

# プロセスの生き死に確認
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

# 終了時のLOCKFILE削除
File.delete(LOCKFILE)
