class CreateStatisticsOrderClicks < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics_order_clicks do |t|

      t.timestamps
    end
  end
end
