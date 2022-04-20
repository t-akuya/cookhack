require 'rails_helper'

RSpec.describe Repertoire, type: :model do
  before do
    @repertoire =FactoryBot.build(:repertoire)
  end

  describe 'レパートリー料理投稿機能' do

    context '投稿できるとき' do
      it "項目が正しく入力されているとき" do
        expect(@repertoire).to be_valid
      end
    end

    context '投稿できないとき' do
      it "画像ファイルが空では投稿できない" do
        @repertoire.image = nil
        @repertoire.valid?
        expect(@repertoire.errors.full_messages).to include("画像ファイルが入力されていません。")
      end

      it "料理名が空では投稿できない" do
        @repertoire.name = nil
        @repertoire.valid?
        expect(@repertoire.errors.full_messages).to include("料理名が入力されていません。")
      end

      it "料理名が41文字以上では投稿できない" do
        @repertoire.name = 'a' * 41
        @repertoire.valid?
        expect(@repertoire.errors.full_messages).to include("料理名は40文字以下に設定して下さい。")
      end

      it "レシピが空では投稿できない" do
        @repertoire.recipe = nil
        @repertoire.valid?
        expect(@repertoire.errors.full_messages).to include("レシピが入力されていません。")
      end

      it "ひとことメモが空では投稿できない" do
        @repertoire.comment = nil
        @repertoire.valid?
        expect(@repertoire.errors.full_messages).to include("ひとことメモが入力されていません。")
      end

      it "カテゴリーが未選択では投稿できない" do
        @repertoire.category_id = 1
        @repertoire.valid?
        expect(@repertoire.errors.full_messages).to include("カテゴリーが選択されていません")
      end

      it "調理時間が未選択では投稿できない" do
        @repertoire.cooking_time_id = 1
        @repertoire.valid?
        expect(@repertoire.errors.full_messages).to include("調理時間が選択されていません")
      end
      
    end
  end
end