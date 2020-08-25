require 'spec_helper'
require 'checkout'
require 'item'
require 'promotions/base'
require 'promotions/lavender_hearts'
require 'promotions/ten_percent_off'

RSpec.describe Checkout do
  subject { Checkout.new(promotional_rules) }

  describe '#total' do
    context 'when there are promotional rules' do
      let(:promotional_rules) do
        [
          lavender_hearts_promotion,
          ten_percent_off_promotion
        ]
      end

      let(:lavender_hearts_promotion) { Promotions::LavenderHearts.new }
      let(:ten_percent_off_promotion) { Promotions::TenPercentOff.new }

      context 'with a basket where ten_percent_off applies' do
        let(:items) do
          [
            Item.new('001', 'Lavender Heart', 925),
            Item.new('002', 'Personalised cufflinks', 4500),
            Item.new('003', 'Kids T-shirt', 1995),
          ]
        end

        before do
          items.each { |item| subject.scan(item) }
        end

        it 'applies the discount and returns the total' do
          expect(subject.total).to eq(6678)
          expect(subject.display_total).to eq('£66.78')
        end
      end

      context 'with a basket where lavender_hearts_promotion applies' do
        let(:items) do
          [
            Item.new('001', 'Lavender Heart', 925),
            Item.new('003', 'Kids T-shirt', 1995),
            Item.new('001', 'Lavender Heart', 925),
          ]
        end

        before do
          items.each { |item| subject.scan(item) }
        end

        it 'applies the discount and returns the total' do
          expect(subject.total).to eq(3695)
          expect(subject.display_total).to eq('£36.95')
        end
      end

      context 'with a basket where both promotions apply' do
        let(:items) do
          [
            Item.new('001', 'Lavender Heart', 925),
            Item.new('002', 'Personalised cufflinks', 4500),
            Item.new('001', 'Lavender Heart', 925),
            Item.new('003', 'Kids T-shirt', 1995),
          ]
        end

        before do
          items.each { |item| subject.scan(item) }
        end

        it 'applies the discount and returns the total' do
          expect(subject.total).to eq(7375.5)
          expect(subject.display_total).to eq('£73.76')
        end
      end
    end
  end
end
