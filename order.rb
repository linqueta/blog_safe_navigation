class Order
  attr_accessor :user, :channel

  def initialize(user, channel)
    @user = user
    @channel = channel
  end
end
