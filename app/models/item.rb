class Item < ActiveRecord::Base

  belongs_to :terminal
  has_many :scan_items

  validates :code, :presence => true, :uniqueness => {:scope => :terminal_id}

end
