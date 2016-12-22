module Utils
  module Forwardable
    def self.included(base)
      base.extend(self)
    end
    def delegate delegate_to, forward_to_method, method_name
      code = %Q[
        def #{method_name} *args, &block
          #{delegate_to}.send(:#{forward_to_method}, *args)
        end
      ]
      class_eval code
    end
  end
end