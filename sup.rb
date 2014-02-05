require_relative 'lib/ext/string.rb'

random_fact = ['You look fucking awesome today', 
				'Did you just get a haircut?',
				'You are awesome',
				'Teach me how to dougie'].sample.upcase

welcome_text = "HELLO DAVE

WELCOME TO YOUR COMPUTER

#{random_fact}"

puts welcome_text.with_box('*')

# Speaks text
# welcome_text.split(/\r?\n/).each { |line| `say #{line}` unless line.length < 5 }