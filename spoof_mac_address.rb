#!/usr/bin/env ruby

require 'highline/import'

puts "\nSpoofing MAC address!\n\n"

DAVE_MACBOOK_PRO_2015_MAC_ADDRESS = `echo $DAVE_MACBOOK_PRO_2015_MAC_ADDRESS`.gsub("\n", '').gsub(/\s*/, '')
DAVE_APPLE_TV_4G_MAC_ADDRESS = `echo $DAVE_APPLE_TV_4G_MAC_ADDRESS`.gsub("\n", '').gsub(/\s*/, '')

puts "• DAVE_MACBOOK_PRO_2015_MAC_ADDRESS = #{DAVE_MACBOOK_PRO_2015_MAC_ADDRESS}"
puts "• DAVE_APPLE_TV_4G_MAC_ADDRESS      = #{DAVE_APPLE_TV_4G_MAC_ADDRESS}"
puts "\n"

cli = HighLine.new
new_mac_address = cli.ask("Enter the MAC address you want to spoof: (e.g. c8:69:cd:03:e2:37)") { |q|
}

cmd = "sudo ifconfig en0 ether #{new_mac_address}"

puts "\n  #{cmd}\n\n"

exit(0) unless HighLine.agree("Run the above command to spoof MAC address?   y/n")

result = `#{cmd}`

if result.length > 0
	puts "\n\n⚠️  Oops! Something went wrong:"
	puts result
	exit(0)
end

verify_cmd = "ifconfig en0 | grep ether"
verify_result = `#{verify_cmd}`
verify_regex = (/#{new_mac_address}/i)
verify_scan = verify_result.scan(verify_regex)
if verify_scan.length == 0
	puts verify_cmd
	puts verify_result
	puts "🚫  Unknown error setting MAC address. Make sure your WiFi is on"
	exit(0)
end

puts "\n✅  Your MAC address has been changed to #{new_mac_address}"
puts "   To change it back to your Mac's default, run `revert_mac_address`\n"