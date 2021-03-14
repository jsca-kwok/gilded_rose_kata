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
    elsif @item.name == 'Conjured Mana Cake'
      ConjuredItem.new(@item)
    else
      NonLegendaryProduct.new(@item)
    end
  end
end

class QualityFactory
  def initialize(item)
    @item = item
  end

  def build
    if @item.quality < 0
      NoQuality.new(@item)
    else
      HasQualityFactory.new(@item).build
    end
  end
end

class HasQualityFactory
  def initialize(item)
    @item = item
  end

  def build
    if @item.quality > 50
      MaxQuality.new(@item)
    else
      NormalQuality.new(@item)
    end
  end
end

class NoQuality
  def initialize(item)
    @item = item
  end
end

class NormalQuality
  def initialize(item)
    @item = item
  end
end

class MaxQuality
  def initialize(item)
    @item = item
  end
end

class Product
  def initialize(item)
    @item = item
  end

  def expired?
    @item.sell_in < 0
  end

  def maxed_quality?
    @item.quality < 50
  end

  def age 
    update_quality
    update_sell_in
    update_quality_again
  end
end

class LegendaryProduct < Product
  def update_sell_in
  end
  
  def update_quality
  end
  
  def update_quality_again
  end
end

class NonLegendaryProduct < Product
  def update_sell_in
    @item.sell_in -= 1
  end
  
  def update_quality
    if @item.quality > 0
      @item.quality -= 1
    end
  end

  def update_quality_again
    if expired?
      update_quality
    end
  end
end


class BackstagePass < NonLegendaryProduct
  def update_quality 
    if maxed_quality?
      @item.quality += 1
      if @item.sell_in < 11
        if maxed_quality?
          @item.quality += 1
        end
      end
      if @item.sell_in < 6
        if maxed_quality?
          @item.quality += 1
        end
      end
    end
  end

  def update_quality_again
    if expired?
      @item.quality = 0
    end
  end
end

class AgedBrie < NonLegendaryProduct
  def update_quality
    if maxed_quality?
      @item.quality += 1
    end
  end

  def update_quality_again
    if expired?
      if maxed_quality?
        @item.quality +=1
      end
    end
  end
end

def update_quality(items)
  items.each do |item|
    ProductFactory.new(item).build.age
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

