# Author: zengtao@gmail.com
# Time:   2020-04-09 18:00
#
# Period 结算周期
# 每个 Period 创建的时候需要检查 所有的 Subscription & 用来创建 Order
# 每个 Period CutOff 的时候需要生成下一个 Period
#
#
class Period < ApplicationRecord

  include AsyncHelper

  # async_helper(:cutoff)

  # ------------------- Class Methods -------------------
  class << self

    def default_duration
      return 1.week
    end

    def current
      period = Period.where("cut_at >= ?", Time.now).last
      Period.last unless period
    end

    def build_new(opts)
      period = Period.create(opts)
      CutoffWorker.perform_at(period, period.cut_at)
    end

  end

  # ------------------- Class Methods End -------------------
  #

  def migrate(cur_at)
    self.update_attributes(cut_at: cur_at)
    PeriodCutoffService.new(self).exec
  end

  # 0. 检查自身状态、确定能够执行 Cutoff 不需要迁移
  # 1. 检查所有 未终止 的订阅 并且 未创建订单的订阅
  # 2. 终止自己、并且创建下一个 Period 实例
  def cutoff
    return unless can_cutoff
    PeriodCutoffService.new(self).exec
  end

  # 强行提前结束的时候调用 force_cutoff
  def force_cutoff
    self.update_attributes(cut_at: Time.now)
    PeriodCutoffService.new(self).exec
  end

  # 这里也可以直接调用批量插入 bulk_insert 之类的
  def check_subscriptions
    Subscription.without_order(self).each do |sub|
      sub.orders.create(
        period: self
      )
    end
  end

  def build_next_period

    period = Period.create(
      start_at: self.cut_at,
      cut_at:   self.cut_at + Period.default_duration
    )

    CutoffWorker.perform_at(period, period.cut_at)

  end

  private

  # 时间没有到的时候直接 Return 掉 （存在推迟 Cutoff 的场景)
  def can_cutoff
    return false if (Time.now <= self.cut_at )
    true
  end

end

# is_active boolean
# start_at
# cut_at
# migrated ?