# frozen_string_literal: true

module Head
  class Sidebar < ::Head::ApplicationComponent
    erb_template <<~ERB
      <div data-group="<%= right ? :right : :left %>" class="c-head-sidebar <%= 'c-head-sidebar--right' if right %> ">
        <% if categories.any? %>
          <div class="c-head-sidebar__categories">
            <% categories.each do |category| %>
              <%= category %>
            <% end %>
          </div>

          <div class="c-head-sidebar__secondary">
            <% categories.select(&:submenu?).each do |category| %>
              <div class="c-head-sidebar__links js-head-sidebar__links" data-identifier="<%= category.identifier %>">
                <% category.links.each do |link| %>
                  <%= link %>
                <% end %>
              </div>
            <% end %>
          </div>
        <% end %>
      </div>
    ERB

    renders_many :categories, ::Head::Sidebars::Category

    option :right, default: -> { false }
  end
end
