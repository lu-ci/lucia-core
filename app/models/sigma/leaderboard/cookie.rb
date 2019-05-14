# frozen_string_literal: true

class Cookie
  include Mongoid::Document
  include Score

  store_in collection: "CookiesResource"

  field :user_id, as: :uid, type: Integer
  field :ranked, as: :score, type: Integer, default: 0
  field :origins, type: Hash, default: { "users": {}, "guilds": {}, "channels": {} }

private

  def prefixes
    @prefixes ||= %w[
      Starving Picky Nibbling Munching Noming
      Glomping Chomping Inhaling Gobbling Devouring
    ].freeze
  end

  def suffixes
    @suffixes ||= %w[
      Licker Taster Eater Chef Connoisseur
      Gorger Epicure Glutton Devourer Void
    ].freeze
  end

  def leveler
    @leveler ||= 5.15
  end
end