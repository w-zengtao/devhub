class CreateOrder < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :period
      t.references :subscription

      t.timestamps
    end
  end
end
