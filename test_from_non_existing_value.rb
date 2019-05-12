class Order
  attr_accessor :user, :channel

  def initialize(user, channel)
    @user = user
    @channel = channel
  end
end

class Channel
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class User
  attr_accessor :wallet

  def initialize(wallet)
    @wallet = wallet
  end
end

class Wallet
  attr_accessor :active

  def initialize(active)
    @active = active
  end
end

user = User.new(Wallet.new(true))
order = Order.new(user, nil)
require 'rails'

require 'benchmark/ips'

Benchmark.ips do |x|
  x.report('&.')  { order&.channel&.name }
  x.report('&&')  { order && order.channel && order.channel.name }
  x.report('try') { order.try(:channel).try(:name) }
  x.compare!
end

# Warming up --------------------------------------
#                   &.   240.906k i/100ms
#                   &&   238.866k i/100ms
#                  try    73.223k i/100ms
# Calculating -------------------------------------
#                   &.      6.450M (± 3.6%) i/s -     32.281M in   5.011781s
#                   &&      6.262M (± 4.0%) i/s -     31.291M in   5.005873s
#                  try    956.368k (± 6.9%) i/s -      4.759M in   5.007394s

# Comparison:
#                   &.:  6450236.3 i/s
#                   &&:  6261813.2 i/s - same-ish: difference falls within error
#                  try:   956367.7 i/s - 6.74x  slower
