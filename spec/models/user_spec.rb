require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー登録" do
    context "全ての項目が存在する場合のテスト" do
      it "name、email、passwordとpassword_confirmationがある場合、有効である" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "nameのテスト" do
      it "nameが20文字以下の場合、有効である" do
        user = build(:user, name: "a" * 20)
        user.valid?
        expect(user).to be_valid
      end

      it "nameが21文字以上の場合、無効である" do
        user = build(:user, name: "a" * 21)
        user.valid?
        expect(user.errors.messages[:name]).to include("は20文字以内で入力してください")
      end

      it "nameが存在してない場合、無効である" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors.messages[:name]).to include("を入力してください")
      end

      it "nameが空白の場合、無効である" do
        user = build(:user, name: " ")
        user.valid?
        expect(user.errors.messages[:name]).to include("を入力してください")
      end

      it "nameが空の場合、無効である" do
        user = build(:user, name: "")
        user.valid?
        expect(user.errors.messages[:name]).to include("を入力してください")
      end
    end

    context "emailのテスト" do
      it "emailが255文字以下の場合、有効である" do
        user = build(:user, email: "a" * 243 + "@example.com" )
        user.valid?
        expect(user).to be_valid
      end

      it "emailが255文字を超える場合、無効である" do
        user = build(:user, email: "a" * 244 + "@example.com")
        user.valid?
        expect(user.errors.messages[:email]).to include("は255文字以内で入力してください")
      end

      it "emailがない場合、無効である"  do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "emailの大文字と小文字を区別せず、一意ではない場合は、無効であること" do
        user = create(:user)
        another_user = build(:user, email: user.email.upcase)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end
    end

    context "passwordのテスト" do
      it "passwordが6文字以上である場合、有効である" do
        user = build(:user, password: "123456", password_confirmation: "123456")
        expect(user).to be_valid
      end

      it "passwordが6文字以下である場合、無効である" do
        user = build(:user, password: "12345", password_confirmation: "12345")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "passwordが存在してもencrypted_passwordがない場合、無効である" do
        user = build(:user, password: "123456", password_confirmation: "")
        user.valid?
        expect(user.errors.full_messages[0]).to include("の入力が一致しません")
      end
    end

  end
end