module Dispatch
  macro counter(names)
    {% for name in names %}
      class {{name.id}}Counter
        def self.increment
          INSTANCE.increment
        end

        def self.decrement
          INSTANCE.decrement
        end

        def self.value
          INSTANCE.value
        end

        def self.reset
          INSTANCE.reset
        end

        private getter counter
        private INSTANCE = new

        private def initialize
          @counter = Atomic(Int32).new(0)
        end

        def increment
          counter.add(1)
          counter.get
        end

        def decrement
          counter.sub(1)
          counter.get
        end

        def value
          counter.get
        end

        def reset
          counter.set(0)
        end
      end
    {% end %}
  end

  counter(["Success", "Failure"])
end
