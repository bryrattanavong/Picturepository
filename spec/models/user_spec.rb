require 'rails_helper'

RSpec.describe(User, type: :model) do
  let(:user) { build(:user) }

  describe 'Check validations' do
    let(:result) { user.valid? }

    it 'valid user' do
      expect(result).to(be(true))
    end

    context 'Check if user has name' do
      before { user.name = nil }

      it 'returns false' do
        expect(result).to(be(false))
      end
    end
    context 'Check if theres an email' do
      before { user.email = nil }

      it 'returns false' do
        expect(result).to(be(false))
      end
    end

    context 'Check for unique email' do
      let(:user2) { create(:user, email: 'test@email.com') }
      before do
        user.email = user2.email
      end
      it 'returns false' do
        expect(result).to(be(false))
      end
    end

    context 'Check for password' do
      before { user.password_digest = nil }
      it 'returns false' do
        expect(result).to(be(false))
      end
    end
  end
end