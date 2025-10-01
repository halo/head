# frozen_string_literal: true

module Head
  class Wing < ApplicationComponent
    erb_template <<~ERB
      <div class="c-head-wing js-head-wing" data-identifier="<%= id %>" data-group="<%= group %>">
        <%= content %>
        <div class="c-head-wing__curtain c-head-wing__curtain--<%= group %> js-head-wing__curtain u-head-smokescreen">
        </div>
      </div>
    ERB

    option :preset, default: -> {}
    option :id, as: :manual_id, default: -> {}
    option :right, default: -> { false }

    def self.mainmenu
      new(id: :mainmenu)
    end

    def id
      return manual_id if manual_id

      preset
    end

    def classes
      %w[c-head-wing js-head-wing]
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

    def preset_mainmenu?
      preset == :mainmenu
    end
  end
end
