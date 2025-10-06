# frozen_string_literal: true

module Head
  module Sidebars
    class Category < ::Head::ApplicationComponent
      erb_template <<~ERB
        <%= link_to url, data:,
                         class: 'c-head-sidebar__category js-head-sidebar__category' do %>
          C:<%= name %>
        <% end %>
      ERB

      renders_many :links, ::Head::Sidebars::Link

      option :url, default: -> { '#' }
      option :name
      option :icon

      def css_classes
        "c-head-sidebar__category #{'js-head-sidebar__category' if submenu?}"
      end

      def data
        return unless submenu?

        { identifier: }
      end

      def submenu?
        url == '#'
      end

      def with_headline(name:)
        with_link(name:, icon: nil)
      end

      def identifier
        @identifier ||= SecureRandom.hex
      end
    end
  end
end
