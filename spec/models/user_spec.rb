require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '1234@'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'あa0000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは不正な値です")
      end

      it 'first_nameが空では入力できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓を入力してください')
      end

      it 'last_nameが空では入力できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください')
      end

      it 'first_name_kanaが空では入力できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓のカナを入力してください')
      end

      it 'last_name_kanaが空では入力できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前のカナを入力してください')
      end

      it 'first_nameが全角でないと登録できない' do
        @user.first_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓は不正な値です')
      end

      it 'last_nameが全角でないと登録できない' do
        @user.last_name = 'ﾊﾝｶｸ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は不正な値です')
      end

      it 'first_name_kanaが全角カタカナでないと登録できない' do
        @user.first_name_kana = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓のカナは不正な値です')
      end

      it 'last_name_kanaが全角カタカナでないと登録できない' do
        @user.last_name_kana = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前のカナは不正な値です')
      end

      it 'birth_dayが空では入力できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
