require 'rails_helper'

RSpec.describe "Repertoires", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @repertoire = FactoryBot.build(:repertoire)
    @ingredient = FactoryBot.build(:ingredient)
  end

  context 'レパートリーが投稿できるとき' do
    it 'ログインしたユーザーは正しい情報を入力すればレパートリー投稿ができ、トップページに移動する' do
      # ログインする
      sign_in(@user)
      # レパートリー投稿ページへ移動する
      visit new_repertoire_path
      # レパートリー情報を入力する
      attach_file "repertoire[image]", "spec/fixtures/test_image.png"
      fill_in 'repertoire-name', with: @repertoire.name
      select '5分以内', from: 'repertoire-cooking-time'
      select '和食', from: 'repertoire-category'
      select '1人分', from: 'repertoire-serving'
      fill_in 'repertoire_ingredients_attributes_0_name', with: @ingredient.name
      fill_in 'repertoire_ingredients_attributes_0_amount', with: @ingredient.amount
      fill_in 'repertoire-info', with: @repertoire.recipe
      fill_in 'repertoire-comment', with: @repertoire.comment
      # 投稿ボタンを押すとレパートリーモデルと材料モデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Repertoire.count }.by(1) and change { Ingredient.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに投稿した内容のレパートリーが表示されていることを確認する(画像)
      expect(page).to have_selector("img[src$='test_image.png']")
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@repertoire.name)
    end
  end

  context 'レパートリーが投稿できないとき' do
    it 'ログインしていないとレパートリー投稿ページに遷移できない' do
      # トップページを表示する
      visit root_path
      # レパートリー投稿ボタンを押す
      find('.post-btn').click
      #ログインページに遷移する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
