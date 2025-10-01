# frozen_string_literal: true

module Head
  class Knob < ApplicationComponent
    erb_template <<~ERB
      <%= link_to(url, class: classes, data: { identifier: id, group: group }) do %>
        <% if icon %>
          <i class="o-headicon <%= icon_class%><%=  %>"></i>
        <% end %>

        <%= content %>
      <% end %>
    ERB

    option :preset, default: -> {}
    option :right, default: -> { false }
    option :id, as: :manual_id, default: -> { false }
    option :icon, as: :manual_icon, default: -> {}

    def self.mainmenu
      new(id: :mainmenu, icon: :bars_bold)
    end

    def id
      return manual_id if manual_id

      preset
    end

    def icon
      return manual_icon if manual_icon

      :'bars-bold' if preset_mainmenu?
    end

    def icon_class
      "o-headicon--#{icon.to_sym.to_s.gsub('_', '-')}"
    end

    def url
      @url.presence || '#'
    end

    def classes
      %w[c-head-knob js-head-knob]
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
