module Sources
  module Base
    class Fetch
      def perform
        raise NotImplementedError
      end
    end
  end
end
