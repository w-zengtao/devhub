# Author: zengtao@gmail.com
# Time:   2020-04-09 22:00
#
# 这里做成服务是觉得可能存在数据的插入高峰 。
# 到时候比较方便在这里分发 Task
#
class PeriodCutoffService

  attr_accessor :period

  def initialize(period)
    @period = period
  end

  def exec
    @period.check_subscriptions
    @period.build_next_period
  end

end