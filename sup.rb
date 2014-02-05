def box_text(some_text, box_char)
	some_text_lines = some_text.split(/\r?\n/)
	line_lengths = some_text_lines.collect { |line| line.length }
	line_length = line_lengths.max

	# Wrap each line in box_char
	some_text_lines = some_text_lines.collect { |line| "#{box_char} #{line.ljust(line_length)} #{box_char}" }

	box_char_line = box_char.ljust(line_length + 4, box_char)

	# Add box_char_line to beginning & end
	some_text_lines.unshift(box_char_line)
	some_text_lines.push(box_char_line)

	some_text_lines
end

random_facts = ['You look fucking awesome today', 
	'Did you just get a haircut?',
	'You are awesome',
	'Teach me how to dougie']

random_fact = random_facts.sample
random_fact.upcase!

welcome_text = "HELLO DAVE

WELCOME TO YOUR COMPUTER

#{random_fact}"

puts box_text(welcome_text, '*')

# Speaks text
# welcome_text.split(/\r?\n/).each { |line| `say #{line}` unless line.length < 5 }