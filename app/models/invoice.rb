class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: [:in_progress, :cancelled, :completed]

  scope :invoices_with_successful_transactions, -> {joins(:transactions).where('transactions.result = ?', 'success').uniq}

  def self.find_all_invoices_with_one_item(item_id)
    joins(:invoice_items).where('invoice_items.item_id = ?', item_id).find_all do |invoice|
      invoice.items.size == 1
    end
  end

  def self.invoices_to_destroy(invoices)
    invoices.each do |invoice|
      invoice.destroy
    end
  end

  def self.destroy_invoices_with_only_one_item_id(item_id)
    invoices = find_all_invoices_with_one_item(item_id)
    invoices_to_destroy(invoices)
  end

end
