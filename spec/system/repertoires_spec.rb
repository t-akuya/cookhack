require 'rails_helper'

RSpec.describe "レパートリー投稿", type: :system do
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

RSpec.describe 'レパートリー編集', type: :system do
  before do
    @repertoire1 = FactoryBot.create(:repertoire)
    @ingredient1 = FactoryBot.create(:ingredient, repertoire: @repertoire1)

    @repertoire2 = FactoryBot.create(:repertoire)
    @ingredient2 = FactoryBot.create(:ingredient, repertoire: @repertoire2)
  end

  context 'レパートリー編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したレパートリーの編集ができる', js: true do
      # レパートリー1を投稿したユーザーでログインする
      sign_in(@repertoire1.user)
      # レパートリー1の投稿詳細ページへ遷移する
      visit repertoire_path(@repertoire1)
      #編集ボタンがあることを確認する
      expect(page).to have_content('この投稿を編集')
      # 編集ボタンを押す
      find('.repertoire-red-btn').click
      # 編集ページへ遷移したことを確認
      expect(current_path).to eq(edit_repertoire_path(@repertoire1))
      # 投稿内容を編集する
      attach_file "repertoire[image]", "spec/fixtures/test_image2.png"
      fill_in 'repertoire-name', with: "#{@repertoire1.name}" + "編集済"
      select '10分以内', from: 'repertoire-cooking-time'
      select '洋食', from: 'repertoire-category'
      select '2人分', from: 'repertoire-serving'
      fill_in 'repertoire_ingredients_attributes_0_name', with: "#{@ingredient1.name}" + "編集済"
      fill_in 'repertoire_ingredients_attributes_0_amount', with: "#{@ingredient1.amount}" + "編集済"
      fill_in 'repertoire-info', with: @repertoire1.recipe
      fill_in 'repertoire-comment', with: @repertoire1.comment
      # 編集を投稿してもrepertoireモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Repertoire.count }.by(0) and change { Ingredient.count }.by(0)
      # 編集が完了し詳細画面に遷移したことを確認する
      expect(current_path).to eq(repertoire_path(@repertoire1))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の投稿が存在することを確認する（画像）
      expect(page).to have_selector "img[src$='test_image2.png']"
      # トップページには先ほど変更した内容の投稿が存在することを確認する（テキスト）
      expect(page).to have_content("#{@repertoire1.name}"+"編集済")
    end
  end

  context 'レパートリー編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したレパートリーの編集画面には遷移できない' do
      # レパートリー1を投稿したユーザーでログインする
      sign_in(@repertoire1.user)
      # レパートリー2の詳細ページに編集ボタンがないことを確認する
      visit repertoire_path(@repertoire2)
      expect(page).to have_no_link 'この投稿を編集', href: edit_repertoire_path(@repertoire2)
    end
    it 'ログインしていないとレパートリーの編集画面には遷移できない' do
      # レパートリー1の詳細ページに遷移する
      visit repertoire_path(@repertoire1)
      # レパートリー1の詳細ページに編集ボタンがないことを確認する
      expect(page).to have_no_link 'この投稿を編集', href: edit_repertoire_path(@repertoire1)
      # レパートリー2の詳細ページに遷移する
      visit repertoire_path(@repertoire2)
      # レパートリー2の詳細ページに編集ボタンがないことを確認する
      expect(page).to have_no_link 'この投稿を編集', href: edit_repertoire_path(@repertoire2)
    end
  end
end


RSpec.describe 'レパートリー削除', type: :system do
  before do
    @repertoire1 = FactoryBot.create(:repertoire)
    @ingredient1 = FactoryBot.create(:ingredient, repertoire: @repertoire1)

    @repertoire2 = FactoryBot.create(:repertoire)
    @ingredient2 = FactoryBot.create(:ingredient, repertoire: @repertoire2)
  end

  context 'レパートリーが削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したレパートリーの削除ができる' do
      # レパートリー1を投稿したユーザーでログインする
      sign_in(@repertoire1.user)
      # レパートリー1の詳細ページに遷移する
      visit repertoire_path(@repertoire1)
      # レパートリー1の詳細ページに削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find('.repertoire-destroy').click
      }.to change { Repertoire.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにはレパートリー1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector "img[src$='test_image2.png']"
    end
  end
  context 'レパートリー削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したレパートリーの削除ができない' do
      # レパートリー1を投稿したユーザーでログインする
      sign_in(@repertoire1.user)
      # レパートリー2の詳細ページに遷移する
      visit repertoire_path(@repertoire2)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('.repertoire-destroy')
    end
    it 'ログインしていないとレパートリーの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # レパートリー1の詳細ページに遷移する
      visit repertoire_path(@repertoire1)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('.repertoire-destroy')
      # レパートリー1の詳細ページに遷移する
      visit repertoire_path(@repertoire2)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('.repertoire-destroy')
    end
  end
end