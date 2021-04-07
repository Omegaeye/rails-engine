class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  enum status: [:disabled, :enabled]

  scope :filter_by_name, -> (name) {where('name ILIKE ?', "%#{name}%")}

  def revenue
    transactions
    .where('result = ?', 'success')
    .pluck('sum(invoice_items.unit_price * invoice_items.quantity)')
    .first
    .round(2)
  end

  def self.top_by_revenue(quantity)
    joins(:transactions)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .where('transactions.result = ?', 'success')
    .group(:id)
    .order('total_revenue desc')
    .limit(quantity)
  end

  def quantity_of_items_sold
    invoices.invoices_with_successful_transactions.sum do |invoice|
      InvoiceItem.sum_of_quantity(invoice.id)
    end
  end

  def self.most_items_merchants(quantity)
    joins(invoice_items: :transactions)
    .select('merchants.*, sum(invoice_items.quantity) as items_quantity')
    .where('transactions.result = ?', 'success')
    .group(:id)
    .order('items_quantity DESC')
    .limit(quantity)
  end
end
