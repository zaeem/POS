class ScanItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :terminal
end
