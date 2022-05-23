require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の新規登録' do
    context '商品の新規登録がうまくいく時' do
      it 'すべての項目が入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の新規登録がうまくいかない時' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('画像を選択してください')
      end

      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end

      it '商品説明が空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('説明を入力してください')
      end

      it 'カテゴリーが未選択では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end

      it '商品の状態が未選択では登録できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end

      it '配送料の負担が未選択では登録できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料を選択してください')
      end

      it '発送元の地域の情報が未選択では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元を選択してください')
      end

      it '発送までの日数が未選択では登録できない' do
        @item.item_send_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end

      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を入力してください')
      end

      it '価格が¥300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格¥300~¥9,999,999の半角数値で入力してください')
      end

      it '価格が¥9,999,999を超えて登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格¥300~¥9,999,999の半角数値で入力してください')
      end

      it '価格は半角数値以外で登録できない' do
        @item.price = 'あ'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格¥300~¥9,999,999の半角数値で入力してください')
      end

      it 'userが紐付いていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
