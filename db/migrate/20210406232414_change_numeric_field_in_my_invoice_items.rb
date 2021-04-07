class ChangeNumericFieldInMyInvoiceItems < ActiveRecord::Migration[5.2]
  def self.up
   change_column :invoice_items, :unit_price, :decimal, :precision => 10, :scale => 2
  end
end
