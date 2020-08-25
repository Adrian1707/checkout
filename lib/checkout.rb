class Checkout
  attr_accessor :basket

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @total = 0
    @basket = []
  end

  def scan(item)
    basket << item
    @total += item.price
  end

  def total
    apply_promotions

    basket.reduce(0) { |sum, item| sum + item.price }
  end

  def display_total
    "£#{(total.to_f / 100).round(2)}"
  end

  private

  attr_reader :promotional_rules

  def apply_promotions
    @apply_promotions ||= promotional_rules.each do |rule|
      rule.apply(basket)
    end
  end
end
