# Author: zengtao@gmail.com
# Time:   2020-04-09 21:00
#

class SubscriptionItem < ApplicationRecord
  belongs_to :item
  belongs_to :subscription
end