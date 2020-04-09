class CreateSubscription < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      # t.references :user
      t.boolean :terminated, default: false , comment: "当设置为 True 的时候代表订阅已经被终止"
      t.timestamps
    end

    # InnoDB & PG 需要加索引
    add_index(:subscriptions, :terminated, name: 'idx_terminated_on_subscription')
  end
end
