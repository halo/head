# frozen_string_literal: true

module Head
  class Active
    include Calls

    option :url
    option :current_path
    option :condition

    def call
      :'is-active' if active?
    end

    private

    def linked_path
      ::URI.parse(url).path
    end

    def active?
      return false if url == '#'

      # Adapted from https://github.com/comfy/active_link_to (MIT license)
      case condition

      when :inclusive, nil # default
        !current_path.match(%r{^#{Regexp.escape(linked_path).chomp('/')}(/.*|\?.*)?$}).blank?

      when :exclusive
        !current_path.match(%r{^#{Regexp.escape(linked_path)}/?(\?.*)?$}).blank?

      when :exact
        current_path == original_url

      when Regexp
        !current_path.match(condition).blank?

      when Array
        controllers = [*condition[0]]
        actions     = [*condition[1]]
        ((controllers.blank? || controllers.member?(params[:controller])) &&
          (actions.blank? || actions.member?(params[:action]))) ||
          controllers.any? do |controller, action|
            params[:controller] == controller.to_s && params[:action] == action.to_s
          end

      when TrueClass
        true

      when FalseClass
        false

      when Hash
        condition.all? do |key, value|
          params[key].to_s == value.to_s
        end
      end
    end
  end
end
