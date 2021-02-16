class CreateMedDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :med_details do |t|
      t.string :category
      t.string :salt
      t.string :med_type
      t.decimal :price, precision: 15, scale: 4
      t.decimal :avg_market_price, precision: 15, scale: 4
      t.string :unit

      t.timestamps
    end
  end
end
