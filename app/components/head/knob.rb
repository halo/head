# frozen_string_literal: true

module Head
  class Knob < ApplicationComponent
    erb_template <<~ERB
      <%= link_to(url, class: classes, data: { identifier: id, group: group }, **options.except(:url)) do %>
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
    option :url, as: :manual_url, default: -> {}
    option :options, default: -> { {} }

    def id
      manual_id || preset
    end

    def icon
      return manual_icon if manual_icon
      return :'bars-thin' if preset_mainmenu?
      return :bell if preset_notifications?
      return :gear if preset_settings?
      return :'question-mark' if preset_help?

      :magnifier if preset_search?
    end

    def icon_class
      "o-headicon--#{icon.to_sym.to_s.gsub('_', '-')}"
    end

    def url
      manual_url || options[:url] || '#'
    end

    def classes
      result = %w[c-head-knob js-head-knob]
      result.push 'c-head-knob--identicon' if preset_identicon?
      result.push 'c-head-knob--avatar' if preset_avatar?
      result
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

    def preset_search?
      preset == :search
    end

    def preset_help?
      preset == :help
    end

    def preset_identicon?
      preset == :identicon
    end

    def preset_avatar?
      preset == :avatar
    end

    def preset_notifications?
      preset == :notifications
    end

    def preset_settings?
      preset == :settings
    end
  end
end
