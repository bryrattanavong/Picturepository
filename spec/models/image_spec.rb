require 'rails_helper'

describe Image, type: :model do
  let(:image) { build(:image) }

  describe 'Check validation' do
    let(:result) { image.valid? }

    context 'Check if image has title' do
      before { image.title = nil }
      it 'returns false' do
        expect(result).to(be(false))
      end
    end

    context 'Check if image has description' do
      before {image.description = nil}
      it "returns false" do
        expect(result).to(be(false))
      end
    end

    context 'Check if image has a price' do
      before { image.price = nil }
      it 'returns false' do
        expect(result).to(be(false))
      end
    end

  end
end