class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name, :unit_price
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  enum status: [:disabled, :enabled]

  scope :filter_by_name, -> (name) { where(["name ILIKE ? or description ILIKE ?", "%#{name}%", "%#{name}%"])}

  scope :filter_by_min_price, -> (price) { where('unit_price >= ?', price.to_i).order(:name)}


  scope :filter_by_max_price, -> (price) { where('unit_price <= ?', price.to_i).order(:name)}



end
