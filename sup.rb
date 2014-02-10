require_relative 'lib/ext/string.rb'

random_fact = ['You look fucking awesome today', 
				'Did you just get a haircut?',
				'FYI you are awesome',
				"BTW You're Funny. Like, LOL style.",
				"Today's outfit = Thumbs up",
				"You have the power to start and *win* a dance-off",
				"Have you been working out?",
				"FYI, all your friends worry they aren't as funny as you.",
				"You pick the best radio stations when you're riding shotgun.",
				"Your sneezes sound like a chorus of angels giggling.",
				"BTW I dig your style."].sample.upcase

welcome_text = "HELLO DAVE

WELCOME TO YOUR COMPUTER

#{random_fact}"

puts welcome_text.with_box('*')

# Speaks text
def speak(some_text)
  some_text.split(/\r?\n/).each { |line| `say -v Victoria "#{line}"` unless line.length < 5 }
end

fork { speak(welcome_text) }

