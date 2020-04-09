class CutoffWorker
  include Sidekiq::Worker

  sidekiq_options on_conflict: :replace
  sidekiq_options unique_across_queues: true, queue: 'period_cutoff'

  def perform(period)
    begin
      period.cutoff
    rescue
      # 一般习惯写到 Redis 里面(被监听) 或者其他的 Sentry 之类的
      Logger.new(STDOUT).error()
    end
  end
end