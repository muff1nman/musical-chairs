#! /usr/bin/env ruby
#
# Copyright © 2014 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
#
# GPL v2
require 'io/console'
require 'json'

# config
quit = "q"
time_lower_bound = 2
time_upper_bound = 30
rear_padding = 10

# gather information on file
file_info_raw = `ffprobe  -print_format json -show_format -v quiet '#{ARGV[0]}'`
file_info = JSON.parse(file_info_raw)
total_duration = file_info["format"]["duration"].to_f
print total_duration

played = 0
loop do
	# break up input file
	r = Random.new
	duration = r.rand(time_lower_bound..time_upper_bound)
	if duration + played > total_duration - rear_padding
		puts "Near end of song"
		break
	end

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

