require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response, :params

    def initialize(env, params)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @headers = {}
      @params = params || {}
    end

    def make_response_404
      status 404
      set_headers
      @response.write('Not found')

      @response.finish
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      send(action)
      set_headers
      write_response

      @response.finish
    end

    private

    def status(status)
      @response.status = status
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_headers
      @headers['Content-Type'] ||= 'text/html'
      
      @headers.each {|key, value| @response[key] = value}
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def render(template)
      @request.env['simpler.template'] = template
    end

  end
end
