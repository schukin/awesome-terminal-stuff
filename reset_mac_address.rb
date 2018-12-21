#!/usr/bin/env ruby

require 'highline/import'

DAVE_MACBOOK_PRO_2015_MAC_ADDRESS = `echo $DAVE_MACBOOK_PRO_2015_MAC_ADDRESS`.gsub("\n", '').gsub(/\s*/, '')

puts "\nResetting MAC address to `#{DAVE_MACBOOK_PRO_2015_MAC_ADDRESS}`\n\n"

if DAVE_MACBOOK_PRO_2015_MAC_ADDRESS.length == 0
	puts "🚫  Please set the env variable DAVE_MACBOOK_PRO_2015_MAC_ADDRESS to your MacBook's MAC address."
	exit(0)
end

cmd = "sudo ifconfig en0 ether #{DAVE_MACBOOK_PRO_2015_MAC_ADDRESS}"

result = `#{cmd}`

if result.length > 0
	puts "\n\n⚠️  Oops! Something went wrong:"
	puts result
	exit(0)
end

verify_cmd = "ifconfig en0 | grep ether"
verify_result = `#{verify_cmd}`
verify_regex = (/#{DAVE_MACBOOK_PRO_2015_MAC_ADDRESS}/i)
verify_scan = verify_result.scan(verify_regex)
if verify_scan.length == 0
	puts verify_cmd
	puts verify_result
	puts "🚫  Unknown error setting MAC address. Make sure your WiFi is on"
	exit(0)
end

puts "\n✅  Your MAC address has been reset to #{DAVE_MACBOOK_PRO_2015_MAC_ADDRESS}"