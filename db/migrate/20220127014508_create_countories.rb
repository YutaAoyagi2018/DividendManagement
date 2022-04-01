class CreateCountories < ActiveRecord::Migration[7.0]
  def change
    create_table :countories do |t|
      t.string :name

      t.timestamps
    end
  end
end
