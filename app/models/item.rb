# 菜品
# 和订阅是多对多的关系
#
class Item < ApplicationRecord
  has_many :subscription_item
  has_many :subscriptions, through: :subscription_item
end