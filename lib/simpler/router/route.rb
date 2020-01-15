module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path.split('/')
        @controller = controller
        @action = action
      end

      def match?(method, path)
        path = path.split('/')
        @method == method && path[1] == @path[1] && !path[2].nil?^@path[2].nil?
      end

    end
  end
end
