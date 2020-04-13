# 菜品
# 和订阅是多对多的关系
#
class Item < ApplicationRecord
  has_many :subscription_item
  has_many :subscriptions, through: :subscription_item

  # Redis Object Operations
  include Redis::Objects
  counter :clicked, start: 0

  def write_to_click_statistics
    statistic = Statistics::ItemClicked.find_or_create_by(item: self, date: Date.today)
    statistic.clicked = self.clicked.value
    statistic.save
    self.clicked.reset
  end

end