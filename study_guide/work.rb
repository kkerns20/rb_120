# main overall namespace
module RegionalFauna

  # lower level namespace module
  module SouthAmerica
    # repeated class name
    class Monkey
      attr_reader :prehesile_tail

      def initialize
        @prehesile_tail = true
      end
    end
  end

  # lower level namespace module
  module Africa
    # repeated class name
    class Monkey
      attr_reader :prehesile_tail

      def initialize
        @prehesile_tail = false
      end
    end
  end
end

spider_monkey = RegionalFauna::SouthAmerica::Monkey.new
baboon = RegionalFauna::Africa::Monkey.new

p spider_monkey.prehesile_tail  # => true
p baboon.prehesile_tail         # => false