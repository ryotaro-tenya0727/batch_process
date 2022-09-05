class AddIndexToRanks < ActiveRecord::Migration[6.1]
  def change
    add_index :ranks, :score
  end
end
