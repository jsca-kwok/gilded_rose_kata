class Product
  def initialize(item)
    @item = item
  end

  def expired?(sell_in)
    true if sell_in < 0
  end

  def maxed_quality?(quality)
    false if quality < 50
  end

  def update_quality
    # if @item is NOT "Aged Brie" or "Backstage pass"
    if @item.name != 'Aged Brie' && @item.name != 'Backstage passes to a TAFKAL80ETC concert'
      # and @item quality is positive
      if @item.quality > 0
        ProductFactory.new(@item).build.update_quality
      end
    else
      # if @item is "Aged Brie" or "Backstage pass" 
      # and quality is less than 50
      if @item.quality < 50
        # then increase quality by 1
        @item.quality += 1
        NonLegendaryProductFactory.new(@item).build.update_quality
      end
    end
  end

  def update_sell_in
    ProductFactory.new(@item).build.update_sell_in
  end

  def update_quality_again 
    # if @item sell in date is negative
    if expired?(@item.sell_in)
      # and the @item is NOT "Aged Brie"
      if @item.name != "Aged Brie"
        # and then @item is NOT "Backstage pass"
        if @item.name != 'Backstage passes to a TAFKAL80ETC concert'
          # and @item quality is positive
          if @item.quality > 0
            ProductFactory.new(@item).build.update_quality
          end
        # if the @item is "Backstage pass"
        else
          NonLegendaryProductFactory.new(@item).build.update_quality
        end
      # if the @item is "Aged Brie"
      else
        # and quality is less than 50
        if @item.quality < 50
          # increase quality by 1
          @item.quality += 1
        end
      end
    end
  end

  def age 
    update_quality
    update_sell_in
    update_quality_again
  end
end

class NonLegendaryProduct < Product
  def initialize(item)
    @item = item
  end
  
  def update_sell_in
    @item.sell_in -= 1
  end
  
  def update_quality
    @item.quality -= 1
  end
end

class LegendaryProduct < Product
  def initialize(item)
    @item = item
  end
  
  def update_sell_in
  end
  
  def update_quality
  end
end

class ProductFactory
  def initialize(item)
    @item = item
  end
  
  def build
    if @item.name != 'Sulfuras, Hand of Ragnaros'
      NonLegendaryProductFactory.new(@item).build
    else
      LegendaryProduct.new(@item)
    end
  end
end

class NonLegendaryProductFactory
  def initialize(item)
    @item = item
  end
  
  def build
    if @item.name == 'Aged Brie'
      AgedBrie.new(@item)
    elsif @item.name == 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePass.new(@item)
    else
      NonLegendaryProduct.new(@item)
    end
  end
end

class BackstagePass < NonLegendaryProduct
  def initialize(item)
    @item = item
  end
  
  def update_quality 
    # and @item has sell in by 11 days
    if @item.sell_in < 11
      # and quality is less than 50
      if !maxed_quality?(@item.quality)
        # then increase quality by 1
        @item.quality += 1
      end
    end
    # if @item is "Backstage pass"
    # and quality is less than 50
    # and @item has sell in by 6 days
    if @item.sell_in < 6
      # and quality is less than 50
      if !maxed_quality?(@item.quality)
        # then increase quality by 1
        @item.quality += 1
      end
    end
    
    if expired?(@item.sell_in)
      @item.quality = 0
    end
  end
end

class AgedBrie < NonLegendaryProduct
  def initialize(item)
    @item = item
  end
  
  def update_quality
  end
end

def update_quality(items)
  items.each do |item|
    Product.new(item).age
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# items = [
#   item.new("+5 Dexterity Vest", 10, 20),
#   item.new("Aged Brie", 2, 0),
#   item.new("Elixir of the Mongoose", 5, 7),
#   item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   item.new("Conjured Mana Cake", 3, 6),
# ]

