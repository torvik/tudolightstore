class Product < ActiveRecord::Base
  has_many :orders, :through => :line_items
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  has_one :stock

  validates :name, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :name, :uniqueness => true

   # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
  if line_items.count.zero?
     return true
  else
      errors[:base] << "Line Items present"
      return false
    end
  end


end
