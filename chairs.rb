#! /usr/bin/env ruby
#
# Copyright © 2014 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
#
# GPL v2

played = 0
loop do
	r = Random.new
	duration = r.rand(2..30)
	puts ARGV.join(" ")
	`ffmpeg -y -t #{duration} -ss 00:#{played / 60 }:#{played % 60} -i '#{ARGV.join(" ")}' segment.mp3`
	`cvlc --play-and-exit segment.mp3`
	played += duration
	puts "Continue? (y/n)"
	input = STDIN.gets.chomp
	if input.casecmp("y") != 0 
		break
	end
end

