# frozen_string_literal: true

module Head
  module Sidebars
    class Link < ::Head::ApplicationComponent
      erb_template <<~ERB
        <%= link_to(url, class: link_classess, **link) do %>
          <% if icon %>
            <%= content_tag :i, nil, class: icon_classes %>
            <% end %>
          <%= content_tag :div, name, class: 'c-head-sidebar__link-name' %>
        <% end %>
      ERB

      option :url, default: -> { '#' }
      option :name
      option :icon
      option :link, default: -> { {} }
      option :icon_class_prefix, default: -> {}
      option :active, default: -> {}

      def link_classess
        "c-head-sidebar__link #{'c-head-sidebar__link-separator' unless icon}  #{active?}".squish
      end

      def icon_classes
        "#{icon_class_prefix}#{icon.to_s.gsub('_', '-')} c-head-sidebar__link-icon"
      end

      def active?
        ::Head::Active.call(url: url_for(url),
                            condition: active,
                            current_path: request.original_fullpath)
      end
    end
  end
end
