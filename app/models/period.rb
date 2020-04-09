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

  async_helper(:cutoff)

  # ------------------- Class Methods -------------------
  class << self

    def default_duration
      return 1.week
    end

    def current
      Period.active.last
    end

    def check_off(period)

    end
  end

  # ------------------- Class Methods End -------------------

  # 0. 检查自身状态、确定能够执行 Cutoff 不需要迁移
  # 1. 检查所有 未终止 的订阅 并且 未创建订单的订阅
  # 2. 终止自己、并且创建下一个 Period 实例
  def cutoff
    Period.check_off(self)
    build_next_period
  end

  def check_subscriptions
  end

  def build_next_period

  end

  private

end

# is_active boolean
# start_at
# cut_at
# migrated ?