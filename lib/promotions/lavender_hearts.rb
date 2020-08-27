module Promotions
  class LavenderHearts < Base
    DISCOUNT_THRESHOLD = 2
    DISCOUNT_APPLIED = 850

    private

    def threshold_is_met?(basket)
      basket.count { |item| item_is_lavender_heart?(item) } >= DISCOUNT_THRESHOLD
    end

    def apply_promotion!(basket)
      basket.map! do |item|
        item.price = DISCOUNT_APPLIED if item_is_lavender_heart?(item)
        item
      end
    end

    def item_is_lavender_heart?(item)
      item.name.downcase.strip == 'lavender heart'
    end
  end
end
