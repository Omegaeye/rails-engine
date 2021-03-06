class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :unit_price, :precision => 8, :scale => 2
      t.belongs_to :merchant, foreign_key: true

      t.timestamps
    end
  end
end
