require 'spec_helper'
require 'checkout'
require 'item'

RSpec.describe Checkout do
  subject { described_class.new(promotional_rules) }
  let(:promotional_rules) { [] }

  describe '#scan' do
    context 'when no items are scanned' do
      it 'returns a zero total' do
        expect(subject.total).to eq(0)
      end
    end

    context 'when one item is scanned' do
      it 'adds the item to the basket and adds to the total' do
        item = instance_double(Item, product_code: '001', name: 'Lavender Heart', price: 925)
        subject.scan(item)

        expect(subject.basket).to eq([item])
        expect(subject.total).to eq(925)
      end
    end

    context 'when multiple items are scanned' do
      it 'adds items to the basket and adds to the total' do
        item_one = instance_double(Item, product_code: '001', name: 'Lavender Heart', price: 925)
        item_two = instance_double(Item, product_code: '002', name: 'Personalised cufflinks', price: 4500)
        [item_one, item_two].each { |item| subject.scan(item) }

        expect(subject.basket).to eq([item_one, item_two])
        expect(subject.total).to eq(5425)
      end
    end
  end

  describe '#total' do
    context 'when there are no promotional rules' do
      let(:promotional_rules) { [] }

      before do
        [
          instance_double(Item, product_code: '001', name: 'Lavender Heart', price: 900),
          instance_double(Item, product_code: '002', name: 'Personalised cufflinks', price: 300)
        ].each { |item| subject.scan(item) }
      end

      it 'returns the sum of the items in the basket' do
        expect(subject.total).to eq(1200)
      end
    end

    context 'when there are promotional rules' do
      let(:promotional_rules) do
        [
          dummy_promotion_one,
          dummy_promotion_two
        ]
      end

      let(:dummy_promotion_one) { double('Promotion', apply: true) }
      let(:dummy_promotion_two) { double('Promotion', apply: true) }

      it 'applies the promotion to the basket' do
        expect(dummy_promotion_one).to receive(:apply)
        expect(dummy_promotion_two).to receive(:apply)

        subject.total
      end
    end
  end
end
