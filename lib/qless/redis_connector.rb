require 'redis'

module Qless
  class RedisConnector
    def initialize(options = {})
      @options = options
    end

    def connect
      ::Redis.new(@options)
    end

    def dup_connection(redis)
      if ::Redis.instance_method(:dup).owner == ::Redis
        redis.dup
      else # redis version < 3.0.7
        connect
      end
    end

    def to_s
      @options.to_s
    end
  end
end
