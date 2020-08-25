require 'spec_helper'
require 'promotions/lavender_hearts'
require 'ostruct'

RSpec.describe Promotions::LavenderHearts do
  describe '#apply' do
    context 'when the condition is not met for the promotion' do
      let(:basket) do
        [
          OpenStruct.new(price: 925, name: 'Lavender Heart'),
          OpenStruct.new(price: 4000, name: 'Kids T-shirt'),
        ]
      end

      it 'does not apply the promotion and returns the basket unchanged' do
        expect(subject.apply(basket)).to eq(basket)
      end
    end

    context 'when the condition is met for the promotion' do
      let(:basket) do
        [
          OpenStruct.new(price: 925, name: 'Lavender Heart '),
          OpenStruct.new(price: 925, name: ' Lavender heart'),
          OpenStruct.new(price: 4000, name: 'Kids T-shirt'),
        ]
      end

      let(:discounted_basket) do
        [
          OpenStruct.new(price: 850, name: 'Lavender Heart '),
          OpenStruct.new(price: 850, name: ' Lavender heart'),
          OpenStruct.new(price: 4000, name: 'Kids T-shirt'),
        ]
      end

      it 'applies the promotion and returns a discounted basket' do
        expect(subject.apply(basket)).to eq(discounted_basket)
      end
    end
  end
end
