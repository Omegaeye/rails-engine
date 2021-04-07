class RevenueAnalytic
  attr_reader :start_date,
              :end_date,
              :id

  def initialize(data)
    @id = nil
    @start_date = data[:start].to_date.midnight
    @end_date = data[:end].to_date.end_of_day
    @invoices = Invoice.all
  end

  def revenue
    @invoices
    .joins(:invoice_items, :transactions)
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .having(created_at: @start_date..@end_date)
    .pluck('sum(invoice_items.quantity * invoice_items.unit_price)').sum
  end
end
