# Author: zengtao@gmail.com
# Time:   2020-04-09 23:00

module Statistics
  class ItemClicked < ApplicationRecord

    self.table_name = 'statistics_item_clicks'

    belongs_to :item
    
    scope :with_period, -> (begin_date, end_date) {
      where("date >= ? and date <= ?", begin_date, end_date)
    }

    scope :sort_by_clicked, -> (date) {

    }

    def self.sort_by_period_clicked(begin_date, end_date)
      self.find_by_sql ["SELECT * FROM (SELECT SUM(clicked) as counter, item_id FROM statistics_item_clicks WHERE(date >= ? and date <= ?) GROUP BY item_id) ORDER BY counter DESC;", begin_date, end_date]
    end
  end
end


# clicked     integer
# date        Date
# item_id     