#!/usr/bin/env ruby
require 'kconv'
require 'open-uri'
require 'json'
head = URI("http://yp.ladio.net/stats/list.v2.dat").read.kconv(Kconv::UTF8)
head.gsub!('"','\"')
heads = head.split("\n\n")

bangumi = []
for item in heads do
	item.gsub!(/^/,'"')
	item.gsub!(/$/,'"')
	item.gsub!(/\n/,",\n")
	item = ('{'+ item + '}')
	atoms = item.split("\n")

	json = "";
	for atom in atoms do
		atom =~ /(^.*)=(.*$)/
		json = json + $1+'":"'+$2
	end
	item = JSON.parse(json)
	bangumi.push(item)
end

num = 0

for item in bangumi do
	print "\n"
	print "\e[35m"
	print "No." + num.to_s + "\n"
	print "\e[0m"
	num = num + 1
	print "Title:\t" + item["NAM"] + "\n"
	print "DJ:\t" + item["DJ"] + "\n"
	print "mount:\t" + item["MNT"]
	print "listener:\t" + item["CLN"]
	print "\n"
end

print "\e[35m"
print "Type Byte Number :"
print "\e[0m"
num = gets.chomp
num = num.to_i

url = "http://"+bangumi[num]["SRV"]+":"+bangumi[num]["PRT"]+bangumi[num]["MNT"]+".m3u"
File.write ENV['HOME'] + '/.ladio', url
