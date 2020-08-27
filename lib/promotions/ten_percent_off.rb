module Promotions
  class TenPercentOff < Base
    DISCOUNT_THRESHOLD = 6000
    DISCOUNT_APPLIED = 0.9

    private

    def threshold_is_met?(basket)
      basket_total = basket.reduce(0) { |sum, item| sum + item.price }
      basket_total > DISCOUNT_THRESHOLD
    end

    def apply_promotion!(basket)
      basket.map! do |item|
        item.price *= DISCOUNT_APPLIED
        item
      end
    end
  end
end
