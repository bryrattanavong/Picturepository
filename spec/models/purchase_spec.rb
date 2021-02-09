require 'rails_helper'

RSpec.describe(Purchase, type: :model) do
  let(:purchase) { build(:purchase) }

  describe 'Check validations' do
    let(:result) { purchase.valid? }

    context 'Check if purchase has a title' do
      before { purchase.title = nil }
      it 'returns false' do
        expect(result).to(be(false))
      end
    end

    context 'Check if purchase has a cost' do
      before { purchase.cost = nil }
      it 'returns false' do
        expect(result).to(be(false))
      end
    end

  end
end