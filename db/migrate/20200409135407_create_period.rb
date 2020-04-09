class CreatePeriod < ActiveRecord::Migration[6.0]
  def change
    create_table :periods do |t|
      t.datetime :start_at
      t.datetime :cut_at
    end
  end
end
