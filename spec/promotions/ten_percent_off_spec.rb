require 'spec_helper'
require 'promotions/ten_percent_off'
require 'ostruct'

RSpec.describe Promotions::TenPercentOff do
  describe '#apply' do
    context 'when the condition is not met for the promotion' do
      let(:basket) do
        [
          OpenStruct.new(price: 1000),
          OpenStruct.new(price: 4000),
        ]
      end

      it 'does not apply the promotion and returns the basket unchanged' do
        expect(subject.apply(basket)).to eq(basket)
      end
    end

    context 'when the condition is met for the promotion' do
      let(:basket) do
        [
          OpenStruct.new(price: 3000),
          OpenStruct.new(price: 4000),
        ]
      end

      let(:discounted_basket) do
        [
          OpenStruct.new(price: 2700),
          OpenStruct.new(price: 3600),
        ]
      end

      it 'applies the promotion and returns a discounted basket' do
        expect(subject.apply(basket)).to eq(discounted_basket)
      end
    end
  end
end
