# frozen_string_literal: true

module Head
  module Sidebars
    class Category < ::Head::ApplicationComponent
      erb_template <<~ERB
        <%= link_to(url, data:,
                         class: 'c-head-sidebar__category js-head-sidebar__category') do %>
          <%= content_tag :i, nil, class: icon_classes %>
          <%= content_tag :div, name, class: 'c-head-sidebar__category-name' %>
        <% end %>
      ERB

      renders_many :links, -> (**options) do
        ::Head::Sidebars::Link.new(icon_class_prefix:, **options)
      end

      option :url, default: -> { '#' }
      option :icon_class_prefix, default: -> {}
      option :name
      option :icon

      def css_classes
        "c-head-sidebar__category #{'js-head-sidebar__category' if submenu?}"
      end

      def icon_classes
        "#{icon_class_prefix}#{icon.to_s.gsub('_', '-')} c-head-sidebar__category-icon"
      end

      def data
        return unless submenu?

        { identifier: }
      end

      def submenu?
        url == '#'
      end

      def with_separator
        with_link(name: nil, icon: nil)
      end

      def identifier
        @identifier ||= SecureRandom.hex
      end
    end
  end
end
