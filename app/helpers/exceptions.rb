module Exceptions
    class ForbiddenTransition < StandardError
        def initialize
            super("The required transition cannot be executed.")
        end
    end
end
