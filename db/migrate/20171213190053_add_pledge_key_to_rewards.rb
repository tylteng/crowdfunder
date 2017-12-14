class AddPledgeKeyToRewards < ActiveRecord::Migration[5.1]
  def change
    change_table :rewards do |t|
      t.integer :pledge_id
    end 
  end
end
