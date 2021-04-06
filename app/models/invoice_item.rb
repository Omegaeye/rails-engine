class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice
  has_one :merchant, through: :item
  has_one :customer, through: :invoice

  validates_presence_of :unit_price, :quantity
  validates :unit_price, :quantity, numericality: { greater_than_or_equal_to: 0 }
  enum status: [:pending, :packaged, :shipped]

  scope :counts_of_items_quantity_that_sold, -> {joins(:transactions).select('invoice_items.*, sum(invoice_items.quantity) as total_quantity').where('transactions.result = ?', 'success').group(:id).total_quantity}

  scope :sum_of_quantity, -> (invoice_id) {where(invoice_id: invoice_id).sum(:quantity)}
end
