class Terminal < ActiveRecord::Base

  has_many :items
  has_many :shopping_carts

  def setPricing(item_code, unit_price, volume_price=nil, volume_qty=nil)
    begin
      self.items.create!({
        code: item_code,
        unit_price: unit_price,
        volume_price: volume_price,
        volume_qty: volume_qty
      })
    rescue => e
      return e
    end
  end

end
