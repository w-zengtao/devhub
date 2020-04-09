# Author: zengtao@gmail.com
# Time:   2020-04-09 18:00
#
class Subscription < ApplicationRecord

  has_many :orders
  has_many :items

  scope :un_terminated, -> { where(terminated: false)}
  scope :without_order, -> (period) {
    un_terminated.where.not(id: Subscription.joins(:orders).where("orders.period_id = ?", period.id)) if period
  }

  # ------------------- Callbacks -------------------

  after_create_commit do
    build_order
  end

  # private

  def build_order
    self.orders.create(period: Period.current)
  end

  # ------------------- Callbacks End -------------------

  public


  # 用户可以终止订阅
  def terminate
    self.update_attributes(terminated: true)
  end

end
