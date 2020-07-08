require 'spec_helper'
require 'qless/redis_connector'

module Qless
  RSpec.describe RedisConnector do
    let(:connector) { described_class.new(RedisHelpers.redis_config) }
    let(:redis) { connector.connect }

    describe '#connect' do
      it do
        expect(redis).to be_a(::Redis)
        expect(redis.ping).not_to be_empty
      end
    end

    describe '#dup_connection' do
      let(:cloned_redis) { connector.dup_connection(redis) }

      it do
        expect(cloned_redis).not_to eq(redis)
        expect(cloned_redis).to be_a(Redis)
        expect(cloned_redis.ping).not_to be_empty
      end
    end

    describe '#to_s' do
      subject(:to_s) { connector.to_s }

      it do
        expect(to_s).to eq(RedisHelpers.redis_config.to_s)
      end
    end
  end
end
