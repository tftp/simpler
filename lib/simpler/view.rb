require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = template_select

      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_path
      path = template_body || [controller.name, action].join('/')

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

    def template_type
      template.first[0] unless template.nil?
    end

    def template_body
      template.first[1] unless template.nil?
    end

    def template_select
      case template_type
      when :plain
        return template_body
      when :file
        return File.read(template_path)
      else
        return File.read(template_path)
      end
    end

  end
end
