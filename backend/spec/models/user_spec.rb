require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }

    it '有効なユーザーであること' do
      expect(user).to be_valid
    end

    it '名前が必須であること' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'メールアドレスが必須であること' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'メールアドレスが一意であること' do
      create(:user, email: "test@example.com")
      duplicate = build(:user, email: "test@example.com")
      expect(duplicate).not_to be_valid
    end

    it 'パスワードが必須であること' do
      user.password = nil
      expect(user).not_to be_valid
    end

    it 'パスワードが6文字以上であること' do
      user.password = '12345'
      expect(user).not_to be_valid
    end
  end
end