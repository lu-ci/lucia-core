# frozen_string_literal: true

require "ostruct"

class GeneralStatistic
  include Mongoid::Document

  store_in collection: "GeneralStats"

  field :name, type: String
  field :guild_count, type: Integer
  field :channel_count, type: Integer
  field :member_count, type: Integer

  class << self
    # rubocop:disable Style/MultilineBlockChain
    def collect_stats
      where(name: :population)
        .each_with_object(guild_count: 0, channel_count: 0, member_count: 0) do |item, acc|
          acc[:guild_count] += item.guild_count if item.guild_count
          acc[:channel_count] += item.channel_count if item.channel_count
          acc[:member_count] += item.member_count if item.member_count
        end
        .then do |obj|
          obj[:command_count] = command_count
          OpenStruct.new(obj)
        end
    end
    # rubocop:enable Style/MultilineBlockChain

    def command_count
      CommandStatistic.all.pluck(:count).sum
    end
  end
end