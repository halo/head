# frozen_string_literal: true

module Head
  module Sidebars
    class Link < ::Head::ApplicationComponent
      erb_template <<~ERB
        <%= link_to url, **link do %>
          L:<%= name %>
        <% end %>
      ERB

      option :url, default: -> { '#' }
      option :name
      option :icon
      option :link, default: -> { {} }
    end
  end
end
