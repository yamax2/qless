require 'redis'

module Qless
  class RedisConnector
    class << self
      attr_accessor :redis_klass
    end

    self.redis_klass = Redis

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def connect
      self.class.redis_klass.new(@options)
    end

    def dup_connection(redis)
      klass = self.class.redis_klass

      if klass.instance_method(:dup).owner == klass
        redis.dup
      else # redis version < 3.0.7
        connect
      end
    end
  end
end
