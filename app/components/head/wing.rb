# frozen_string_literal: true

module Head
  class Wing < ApplicationComponent
    erb_template <<~ERB
      <div class="<%= classes.join(' ') %>" data-identifier="<%= id %>" data-group="<%= group %>">
        <%= content %>
        <div class="c-head-wing__curtain c-head-wing__curtain--<%= group %> js-head-wing__curtain u-head-smokescreen">
        </div>
      </div>
    ERB

    option :id, as: :id, default: -> {}
    option :right, default: -> { false }

    def self.mainmenu
      new(id: :mainmenu)
    end


    def classes
      %W[c-head-wing c-head-wing--#{group} js-head-wing]
    end

    def group
      left? ? :left : :right
    end

    def left?
      !right?
    end

    def right?
      @right
    end
  end
end
