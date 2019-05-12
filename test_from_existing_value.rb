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
  x.report('&.')  { order&.user&.wallet&.active }
  x.report('&&')  { order && order.user && order.user.wallet && order.user.wallet.active }
  x.report('try') { order.try(:user).try(:wallet).try(:active) }
  x.compare!
end

# Warming up --------------------------------------
#                   &.   212.688k i/100ms
#                   &&   183.962k i/100ms
#                  try    34.841k i/100ms
# Calculating -------------------------------------
#                   &.      4.915M (± 6.6%) i/s -     24.459M in   5.002834s
#                   &&      3.279M (±11.0%) i/s -     16.189M in   5.010593s
#                  try    389.227k (± 9.1%) i/s -      1.951M in   5.060125s

# Comparison:
#                   &.:  4915070.0 i/s
#                   &&:  3279389.3 i/s - 1.50x  slower
#                  try:   389227.4 i/s - 12.63x  slower
