require './lib/item'
require './lib/attendee'
require './lib/auction'

describe Auction do
  before :each do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
    @auction = Auction.new
  end

  it "exists" do
    expect(@auction).to be_a(Auction)
  end

  it 'has items and can add items' do
    expect(@auction.items).to eq([])
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    expect(@auction.items).to eq([@item1, @item2])
  end

  it 'can pull items names' do
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
  end

  it 'can see items bids' do
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    expect(@item1.bids).to eq({})
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    expect(@item1.bids).to eq({
      @attendee2 => 20,
      @attendee1 => 22
      })
    expect(@item1.current_high_bid).to eq(22)
  end

  it "can check unpopuler items" do
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
    @item3.add_bid(@attendee2, 15)
    expect(@auction.unpopular_items).to eq([@item2, @item5])

  end

  it 'can check auctions potential revenue' do
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    expect(@auction.potential_revenue).to eq(87)
  end
end
