require './lib/vendor'
require './lib/item'
require './lib/market'

RSpec.describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market") 
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")  
    @vendor3 = Vendor.new("Palisade Peach Shack") 
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  describe "#initialize" do
    it 'exists' do
      expect(@market).to be_an_instance_of(Market)
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to eq([])
    end
  end

  describe "#add_vendor" do
    it 'can add a vendor' do
      expect(@market.vendors).to eq([])
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end

  describe '#vendor_names' do
    it 'can return a list of vendor names' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#vendors_that_sell(item)' do
    it 'can return a list of vendors that sell the item' do
      @vendor1.stock(@item1, 35) 
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end 

  describe '#sorted_item_list' do
    it 'can return a list of items vendors have in stock sorted alphabetically' do
      @vendor1.stock(@item1, 35) 
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.sorted_item_list).to eq([@item4.name, @item1.name, @item3.name, @item2.name])
    end
  end

  describe '#total_inventory' do
    it 'can return the total number of items vendors have in stock' do
      @vendor1.stock(@item1, 35) 
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.total_inventory).to eq({@item1 => {quantity: 100, vendor: [@vendor1, @vendor2]}, @item2 => {quantity: 7, vendor: [@vendor1]}, @item3 => {quantity: 25, vendor: [@vendor2],}, @item4 => {quantity: 50, vendor: [@vendor2]}})
    end
  end

  describe '#overstocked_items' do
    it 'can return a list of items that are overstocked' do
      @vendor1.stock(@item1, 35) 
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50) 
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
    end
  end
end 