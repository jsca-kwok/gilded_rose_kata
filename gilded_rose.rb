class Product
  def initialize(item)
    @item = item
  end

      # if item is NOT "Aged Brie" or "Backstage pass"
      if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
        # and item quality is positive
        if item.quality > 0
          # and item is not "Sulfuras"
          if item.name != 'Sulfuras, Hand of Ragnaros'
            # then decrease item quality by 1
            item.quality -= 1
          end
        end
      else
        # if item is "Aged Brie" or "Backstage pass" 
        # and quality is less than 50
        if item.quality < 50
          # then increase quality by 1
          item.quality += 1
          # if item is "Backstage pass" 
          # and quality is less than 50
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            # and item has sell in by 11 days
            if item.sell_in < 11
              # and quality is less than 50
              if item.quality < 50
                # then increase quality by 1
                item.quality += 1
              end
            end
            # if item is "Backstage pass"
            # and quality is less than 50
            # and item has sell in by 6 days
            if item.sell_in < 6
              # and quality is less than 50
              if item.quality < 50
                # then increase quality by 1
                item.quality += 1
              end
            end
          end
        end
      end
  
      # if item is NOT "Sulfuras"
      if item.name != 'Sulfuras, Hand of Ragnaros'
        # decrease sell in date
        item.sell_in -= 1
      end
  
      # if item sell in date is negative
      if item.sell_in < 0
        # and the item is NOT "Aged Brie"
        if item.name != "Aged Brie"
          # and then item is NOT "Backstage pass"
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            # and item quality is positive
            if item.quality > 0
              # and the item is NOT "Sulfuras"
              if item.name != 'Sulfuras, Hand of Ragnaros'
                # decrease quality by 1
                item.quality -= 1
              end
            end
          # if the item is "Backstage pass"
          else
            # item quality is 0
            item.quality = item.quality - item.quality
          end
        # if the item is "Aged Brie"
        else
          # and quality is less than 50
          if item.quality < 50
            # increase quality by 1
            item.quality += 1
          end
        end
      end
    end
end

def update_quality(items)
  items.each do |item|
    Product.new(item)
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

