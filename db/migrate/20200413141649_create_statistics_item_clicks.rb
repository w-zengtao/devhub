class CreateStatisticsItemClicks < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics_item_clicks do |t|
      t.references :item
      t.integer    :clicked, default: 0
      t.date       :date
    end

    add_index(:statistics_item_clicks, [:item_id, :date], unique: true, name: 'idx_item_clicks_uniq')
  end
end
