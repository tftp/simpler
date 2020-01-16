module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :path, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path.split('/')
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        path = path.split('/')
        @method == method && path[1] == @path[1] && !path[2].nil?^@path[2].nil?
      end

      def has_params?
        !@path[2].nil?
      end

      def add_params(env)
        path = env['PATH_INFO'].split('/')
        @params[:id] = path[2] if has_params?
        query_string = env['QUERY_STRING'].split('&')
        return if query_string.nil?

        query_string.each { |params| params = params.split('='); @params[params[0]] = params[1] }
      end

    end
  end
end
