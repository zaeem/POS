class ShoppingCart < ActiveRecord::Base
  belongs_to :terminal
  has_many :scan_items

  def scan(item_code=nil)

    item = self.terminal.items.find_by(code: item_code) rescue nil
    if item.present?
      self.scan_items.create(item_id: item.id)
    else
      "This item doesn't exist."
    end
  end

  def result
    total_amount = 0
    self.scan_items.group_by(&:item_id).each do |scan_items_hash|
      # get the scan_items of specific item_id
      scan_items = scan_items_hash.second
      # get that specific item
      scaned_item = Item.find(scan_items.first.item_id)
      # get # times specific item scanned
      scan_items_count = scan_items.count

      if scaned_item.volume_qty.present?

        while scan_items_count >= scaned_item.volume_qty  do
          scan_items_count = scan_items_count - scaned_item.volume_qty
          total_amount = total_amount + scaned_item.volume_price
        end

      end

      if scan_items_count > 0
        total_amount = total_amount + (scan_items_count * scaned_item.unit_price)
      end

    end
    return ActionController::Base.helpers.number_to_currency(total_amount, :unit => "$")
  end

end
