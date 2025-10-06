# frozen_string_literal: true

module Head
  class Theater < ApplicationComponent
    erb_template <<~ERB
      <div class="c-head-theater">
        <div class="c-head-theater__roof">

          <div class="c-head-theater__knobs c-head-theater__knobs--left">
            <% Array(knobs).select(&:left?).each do |knob| %>
              <%= knob %>
            <% end %>
          </div>

          <div class="c-head-theater__logo">
            <%= logo %>
          </div>

          <div class="c-head-theater__knobs c-head-theater__knobs--right">
            <% Array(knobs).select(&:right).each do |knob| %>
              <%= knob %>
            <% end %>
          </div>

        </div>
        <div class="c-head-theater__stage">

          <div class="c-head-theater__wings c-head-theater__wings--left">
          <%# fail wings.first.content.inspect %>
            <% Array(wings).select(&:left?).each do |wing| %>
              <%= wing %>
            <% end %>
          </div>

          <div class="c-head-theater__content">
            <%= body %>
          </div>

          <div class="c-head-theater__wings c-head-theater__wings--right">
            <% Array(wings).select(&:right?).each do |wing| %>
              <%= wing %>
            <% end %>
          </div>
        </div>
      </div>
    ERB

    def with_mainmenu(&)
      with_knob(preset: :mainmenu)
      with_wing(id: :mainmenu, &)
    end

    def with_help(&)
      with_knob(preset: :help, right: true)
      with_wing(id: :help, right: true, &)
    end

    def with_notifications(&)
      with_knob(preset: :notifications, right: true)
      with_wing(id: :notifications, right: true, &)
    end

    def with_settings(&)
      with_knob(preset: :settings, right: true)
      with_wing(id: :settings, right: true, &)
    end

    def with_search(**options)
      with_knob(preset: :search, options:)
    end

    def with_identicon(username:, &)
      with_knob(preset: :identicon, right: true) do
        ::Head::Identicon.new(username.to_s).to_svg
      end
      with_wing(id: :identicon, right: true, &)
    end

    def with_avatar(image:, &)
      with_knob(preset: :avatar, right: true) do
        image_tag(image)
      end
      with_wing(id: :avatar, right: true, &)
    end

    renders_many :knobs, ::Head::Knob
    renders_many :wings, ::Head::Wing

    renders_one :logo
    renders_one :body
  end
end
