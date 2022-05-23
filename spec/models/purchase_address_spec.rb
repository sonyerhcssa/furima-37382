require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
      # sleep 0.01 # 0.01秒待機
    end

    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end
      it 'buildingが空でも保存できること' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('郵便番号を入力してください')
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('郵便番号に半角のハイフンを含んでください')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it 'cityが空だと保存できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('市区町村を入力してください')
      end
      it 'addressが空だと保存できないこと' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('番地を入力してください')
      end
      it 'phone_numberが空では登録できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'phone_numberが10桁未満の半角英数字では登録できないこと' do
        @purchase_address.phone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は正しい桁数で入力してください')
      end
      it 'phone_numberが12桁以上の半角英数字では登録できないこと' do
        @purchase_address.phone_number = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は正しい桁数で入力してください')
      end
      it 'phone_numberに全角文字が入っている場合は登録できないこと' do
        @purchase_address.phone_number = '１２３４５６７８９０１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は数値で入力してください')
      end
      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('カード情報を入力してください')
      end
      it 'user_idが空では登録できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Userを入力してください')
      end
      it 'item_idが空では登録できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
