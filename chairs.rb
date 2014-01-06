#! /usr/bin/env ruby
#
# Copyright © 2014 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
#
# GPL v2
require 'io/console'

# config
quit = "q"
time_lower_bound = 2
time_upper_bound = 30

played = 0
loop do
	# break up input file
	r = Random.new
	duration = r.rand(time_lower_bound..time_upper_bound)
	`ffmpeg -y -t #{duration} -ss 00:#{played / 60 }:#{played % 60} -i '#{ARGV[0]}' segment.mp3`

	# play segment
	`cvlc --play-and-exit segment.mp3`
	played += duration

	# prompt for repeat
	puts "Any key to continue or \"#{quit}\" to quit"
	input = STDIN.getch
	if input.casecmp(quit) == 0
		break
	end
end

