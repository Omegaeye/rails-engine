class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  scope :invoices_with_successful_transactions, -> {joins(:transactions).where('transactions.result = ?', 'success').uniq}

  # def self.destroy_invoices_with_only_one_item_id(item_id)
  #   invoice_ids = joins(:invoice_items).where('invoice_items.item_id = ?', item_id).find_all do |invoice|
  #     invoice.items.size == 1
  #   end
  #   Invoice.destroy(invoice_ids)
  # end
  #
  # def self.invoices_to_destroy(invoices)
  #   invoices.each do |invoice|
  #     invoice.destroy
  #   end
  # end
  #
  # def self.destroy_invoices_with_only_one_item_id(item_id)
  #   invoices = find_all_invoices_with_one_item(item_id)
  #   invoices_to_destroy(invoices)
  # end

  def self.delete_invoice
    invoice_ids = joins(:items)
    .select("invoices.*, count(items.*)")
    .group("invoices.id")
    .having("count(items.*) = 1").pluck(:id)
    Invoice.destroy(invoice_ids)
  end

end
