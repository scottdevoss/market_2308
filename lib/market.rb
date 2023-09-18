class Market 
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    all_names = []
    @vendors.each do |vendor|
      all_names << vendor.name
    end
    all_names
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory.include?(item)
    end 
  end

  def sorted_item_list
    sorted_names = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        item_name = item.name
        if !sorted_names.include?(item_name)
          sorted_names << item_name
          sorted_names.sort!
        end
      end 
    end
    sorted_names
  end

  def total_inventory
    total = {}
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        vendor.inventory.values.each do |value|

          require 'pry'; binding.pry
          total[item] = {:quantity => value, :vendor => vendor}
        end
        #thought I might have been on to something - just ran out of time.
        #probably overthinking it?
      end 
    end 
  end
end