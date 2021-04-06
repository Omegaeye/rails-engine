class MerchantMostItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attributes :count do |merchant|
    merchant.quantity_of_items_sold
  end
end
