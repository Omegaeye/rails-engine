class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.belongs_to :customer, foreign_key: true
      t.belongs_to :merchant, foreign_key: true
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
