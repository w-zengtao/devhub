# Author: zengtao@gmail.com
# Time:   2020-04-09 18:00
#
class Subscription < ApplicationRecord

  has_many :orders
  has_many :items

  scope :un_terminated, -> {}

  # ------------------- Callbacks -------------------

  after_create_commit do
    self.build_order
  end

  private

  def build_order
    self.orders.create()
  end

  # ------------------- Callbacks End -------------------

  public


  # 用户可以终止订阅
  def terminate

  end

end
