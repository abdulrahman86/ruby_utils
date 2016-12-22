module Utils
  module Aspects

    def self.included(base)
      base.extend(self)
    end

    def around_aspect(method_name, before_proc, after_proc)

      new_method_name = Random.new_seed.to_s

      alias_method :"#{new_method_name}", :"#{method_name}"

      define_method "#{method_name}" do |*args, &block|
        before_proc.call
        send(:"#{new_method_name}", *args, &block)
        after_proc.call
      end
    end

    def before_aspect method_name, before_proc
      around_aspect method_name, before_proc, ->(){}
    end

    def after_aspect method_name, after_proc
      around_aspect method_name, ->(){}, after_proc
    end
  end
end


class Test
  include Utils::Aspects

  def test

    puts 'test'
  end

  before = ->(){puts 'before'}
  after = ->(){puts 'after'}

  before_aspect :test, before
  after_aspect :test, after
end


Test.new.test






