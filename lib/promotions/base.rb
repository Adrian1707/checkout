module Promotions
  class Base
    def apply(basket)
      apply_promotion!(basket) if threshold_is_met?(basket)

      basket
    end
  end
end
