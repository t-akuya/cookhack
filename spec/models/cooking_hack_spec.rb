require 'rails_helper'

RSpec.describe CookingHack, type: :model do
  before do
    @cooking_hack = FactoryBot.build(:cooking_hack)
    @cooking_hack.hack_image = fixture_file_upload("/test_image.png")
  end

  describe '時短テクニック投稿機能' do

    context '投稿できるとき' do
      it "項目が正しく入力されているとき" do
        expect(@cooking_hack).to be_valid
      end
    end

    context '投稿できないとき' do
      it "画像ファイルが空では投稿できない" do
        @cooking_hack.hack_image = nil
        @cooking_hack.valid?
        expect(@cooking_hack.errors.full_messages).to include("画像が入力されていません。")
      end

      it "タイトルが空では投稿できない" do
        @cooking_hack.title = nil
        @cooking_hack.valid?
        expect(@cooking_hack.errors.full_messages).to include("Hackタイトルが入力されていません。")
      end

      it "タイトルが41文字以上では投稿できない" do
        @cooking_hack.title = 'a' * 41
        @cooking_hack.valid?
        expect(@cooking_hack.errors.full_messages).to include("Hackタイトルは40文字以下に設定して下さい。")
      end

      it "時短テクニックの内容が空では投稿できない" do
        @cooking_hack.contents = nil
        @cooking_hack.valid?
        expect(@cooking_hack.errors.full_messages).to include("時短テクニックの内容が入力されていません。")
      end
    end
  end

end
