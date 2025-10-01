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
      with_wing(preset: :mainmenu, &)
    end

    renders_many :knobs, ::Head::Knob
    renders_many :wings, ::Head::Wing

    renders_one :logo
    renders_one :body
  end
end
