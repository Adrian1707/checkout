module Promotions
  class Base
    def apply(basket)
      apply_promotion!(basket) if condition_is_met?(basket)

      basket
    end
  end
end
