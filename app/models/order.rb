# Author: zengtao@gmail.com
# Time:   2020-04-09 21:00
#

class Order < ApplicationRecord

  belongs_to :subscription
  belongs_to :period


end
