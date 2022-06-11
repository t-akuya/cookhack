require 'rails_helper'

RSpec.describe Repertoire, type: :model do
  before do
    @ingredient = FactoryBot.build(:ingredient)
  end

  context '投稿できるとき' do

    it "項目(材料、分量)が正しく入力されているとき" do
      expect(@ingredient).to be_valid
    end

  end

  context '投稿できないとき' do

    it "材料が空では投稿できない" do
      @ingredient.name = nil
      @ingredient.valid?
      expect(@ingredient.errors.full_messages).to include("Nameが入力されていません。")
    end

    it "分量が空では投稿できない" do
      @ingredient.amount = nil
      @ingredient.valid?
      expect(@ingredient.errors.full_messages).to include("Amountが入力されていません。")
    end
  end

end
