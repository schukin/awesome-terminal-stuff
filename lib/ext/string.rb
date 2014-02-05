class String
	def with_box(box_char)
		self_lines = self.split(/\r?\n/)
		line_lengths = self_lines.collect { |line| line.length }
		line_length = line_lengths.max

		# Wrap each line in box_char
		self_lines = self_lines.collect { |line| "#{box_char} #{line.ljust(line_length)} #{box_char}" }

		box_char_line = box_char.ljust(line_length + 4, box_char)

		# Add box_char_line to beginning & end
		self_lines.unshift(box_char_line)
		self_lines.push(box_char_line)

		self_lines.join("\n")
	end
end