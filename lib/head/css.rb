# frozen_string_literal: true

module Head
  # Simple helper to unify Strings and Arrays of CSS class names.
  class Css
    def self.call(*input)
      Array(input).flatten.compact.join(' ')
    end
  end
end
