# frozen_string_literal: true

require 'digest/md5'

module Head
  class Identicon
    DARK_COLORS = %w[#39FF14 #FF3131 #1F51FF #FFE700 #F000FF #7FFF00 #CCFF00 #FF5E00 #00FFFF].freeze
    LIGHT_COLORS = [
      'A799B7', # gray
      'E384FF', # rose
      'c300cE', # purple
      'F8DE22', # yellow
      '9EDDFF', # light blue
      'FF004D', # red
      'F72798', # pink
      'FFAF00', # orange
      '39FF14'  # neon grass green
    ].freeze
    GRID_SIZE = 5
    HALF_GRID = (GRID_SIZE / 2.0).round
    DENSITY = 0.5

    def initialize(input, theme: :light)
      @seed = Digest::MD5.hexdigest(input).to_i(16)
      @random = Random.new(@seed)
      colors = theme == :light ? LIGHT_COLORS : DARK_COLORS
      @color = colors[@seed % (LIGHT_COLORS.size - 1)]
    end

    def to_svg
      svg = +%(<svg viewBox="0 0 5 5" xmlns="http://www.w3.org/2000/svg" fill="" shape-rendering="crispEdges">)
      GRID_SIZE.times do |row|
        HALF_GRID.times do |column|
          add_pixel(column, row, svg) if @random.rand < DENSITY
        end
      end
      svg << '</svg>'
      svg.html_safe
    end

    private

    def add_pixel(column, row, svg)
      positions = [[column, row]]
      mirrored_column = GRID_SIZE - 1 - column
      positions << [mirrored_column, row] unless column == mirrored_column

      positions.each do |current_column, current_row|
        svg << %(<rect x="#{current_column}" y="#{current_row}" width="1" height="1" fill="##{@color}"></rect>)
      end
    end
  end
end
