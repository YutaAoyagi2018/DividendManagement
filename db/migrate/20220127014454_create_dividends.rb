class CreateDividends < ActiveRecord::Migration[7.0]
  def change
    create_table :dividends do |t|
      t.integer :countory_id
      t.string :code
      t.string :name
      t.date :income_date
      t.float :dividend_per_share
      t.integer :shares
      t.integer :actual_dividend

      t.timestamps
    end
  end
end
