class ChangeUnitPriceToBePrecision10InInvoiceItems < ActiveRecord::Migration[5.2]
  def up
    change_column :invoice_items, :unit_price, :decimal
  end

  def up
    change_column :invoice_items, :unit_price, :decimal, precision: 8, scale: 2
  end
end
