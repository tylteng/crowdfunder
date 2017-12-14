class AddLimitToRewards < ActiveRecord::Migration[5.1]
  def change
    change_table  :rewards do |t|
      t.integer :limit, default: 5
    end
  end
end
