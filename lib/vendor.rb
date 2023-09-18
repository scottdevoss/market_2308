class Vendor
  attr_reader :name, :inventory, :stock
  def initialize(name)
    @name = name
    @inventory = {}
    @stock = 0
  end

  def check_stock(item)
    @stock
  end

  def stock(item, inventory)

  end
end