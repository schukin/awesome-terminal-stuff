random_facts = ['You look fucking awesome today', 
	'Did you just get a haircut?',
	'You are awesome',
	'Teach me how to dougie']

random_fact = random_facts.sample
random_fact.upcase!

welcome_text = "HELLO DAVE

WELCOME TO YOUR COMPUTER

#{random_fact}"

welcome_text_lines = welcome_text.split(/\r?\n/)
line_lengths = welcome_text_lines.collect { |line| line.length }
line_length = line_lengths.max

# Wrap each line in '*'
welcome_text_lines = welcome_text_lines.collect { |line| "* #{line.ljust(line_length)} *" }

starline = '*'.ljust(line_length + 4, '*')

# Add starline to beginning & end
welcome_text_lines.unshift(starline)
welcome_text_lines.push(starline)

puts welcome_text_lines

# puts "****************************
# * HELLO DAVE               
# *                          
# * WELCOME TO YOUR COMPUTER 
# *                          
# * #{random_fact}
# ****************************"