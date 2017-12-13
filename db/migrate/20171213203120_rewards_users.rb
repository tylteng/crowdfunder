class RewardsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards_users do |t|
      t.integer :reward_id, null: false
      t.integer :user_id, null:false
    end
  end
end
