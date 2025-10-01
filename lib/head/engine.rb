# frozen_string_literal: true

require 'rails/engine'

module Head
  # :nodoc:
  class Engine < ::Rails::Engine
    isolate_namespace Head

    config.autoload_paths << root.join('lib')

    initializer 'head.importmap', before: 'importmap' do |app|
      app.config.importmap.paths << Engine.root.join('config/importmap.rb')
      # Watch JS changes in development
      app.config.importmap.cache_sweepers << Engine.root.join('app/assets/javascripts')
    end

    config.to_prepare do
      # Our Head components are subclasses of `ViewComponent::Base`.
      # When `ViewComponent::Base` is subclassed, two things happen:
      #
      #   1. Rails routes are included into the component
      #   2. The ViewComponent configuration is accessed
      #
      # So we can only require our components, once Rails has booted
      # AND the view_component gem has been fully initialized (configured).
      #
      # That's right here and now.
      require_relative '../../app/components/head/application_component'

      # Components
      require_relative '../../app/components/head/wing'
      require_relative '../../app/components/head/knob'
      require_relative '../../app/components/head/theater'
    end
  end
end
