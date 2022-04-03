=begin
Behold this incomplete class for constructing boxed banners.
Complete this class so that the test cases shown below work as intended. You 
are free to add any methods or instance variables you need. However, do not 
make the implementation details public.

You may assume that the input will always fit in your terminal window.

Test Cases
----------

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

banner = Banner.new('')
puts banner
+--+
|  |
|  |
|  |
+--+

=end

class Banner
  def initialize(message, width=message.size)
    @message = message
    @width = width
  end

  def to_s
    message_lines = format_message.map { |line| message_line(line) }
    [horizontal_rule, empty_line, *message_lines, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * @width}-+"
  end

  def empty_line
    "| #{' ' * @width} |"
  end

  def message_line(line)
    "| " + line.center(@width) + " |"
  end

  def format_message
    words = @message.split(' ')
    lines = []
    line = []
    until words.empty?
      if (line + [words.first]).join(' ').size <= @width
        line << words.shift
      else
        lines << line
        line = []
      end
    end
    lines << line
    lines.map { |line| line.join(' ') }
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
banner = Banner.new('To boldly go where no one has gone before.', width=60)
puts banner
banner = Banner.new('To boldly go where no one has gone before.', width=40)
puts banner

banner = Banner.new('To boldly go where no one has gone before. Four score and seven years ago. Long live the queen.')
puts banner
banner = Banner.new('To boldly go where no one has gone before. Four score and seven years ago. Long live the queen.', width=60)
puts banner
banner = Banner.new('To boldly go where no one has gone before. Four score and seven years ago. Long live the queen.', width=40)
puts banner

banner = Banner.new('')
puts banner
banner = Banner.new('', width=60)
puts banner
banner = Banner.new('', width=40)
puts banner