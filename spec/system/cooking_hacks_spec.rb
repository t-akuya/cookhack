require 'rails_helper'

RSpec.describe '時短裏技投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @cooking_hack = FactoryBot.build(:cooking_hack)
  end

  context '時短裏技が投稿できるとき' do
    it 'ログインしたユーザーは正しい情報を入力すれば時短裏技投稿ができ、トップページに移動する' do
      # ログインする
      sign_in(@user)
      # 時短裏技投稿ページへ移動する
      visit new_cooking_hack_path
      # 時短裏技情報を入力する
      attach_file 'cooking_hack[hack_image]', 'spec/fixtures/test_image.png'
      fill_in 'repertoire-name', with: @cooking_hack.title
      fill_in 'repertoire-comment', with: @cooking_hack.contents
      # 投稿ボタンを押すとcooking_hackモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { CookingHack.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに投稿した内容の時短裏技が表示されていることを確認する(画像)
      expect(page).to have_selector("img[src$='test_image.png']")
      # トップページには先ほど投稿した内容の時短裏技が存在することを確認する（テキスト）
      expect(page).to have_content(@cooking_hack.title)
    end
  end

  context '時短裏技が投稿できないとき' do
    it 'ログインしていないと時短裏技投稿ページに遷移できない' do
      # トップページを表示する
      visit root_path
      # レパートリー投稿ボタンを押す
      find('.hack-post-btn').click
      # ログインページに遷移する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '時短裏技編集', type: :system do
  before do
    @cooking_hack1 = FactoryBot.create(:cooking_hack)
    @cooking_hack2 = FactoryBot.create(:cooking_hack)
  end

  context '時短裏技の編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した時短裏技の編集ができる' do
      # 時短裏技1を投稿したユーザーでログインする
      sign_in(@cooking_hack1.user)
      # 時短裏技1の投稿詳細ページへ遷移する
      visit cooking_hack_path(@cooking_hack1)
      # 編集ボタンがあることを確認する
      expect(page).to have_content('この投稿を編集')
      # 編集ボタンを押す
      find('.repertoire-red-btn').click
      # 編集ページへ遷移したことを確認
      expect(current_path).to eq(edit_cooking_hack_path(@cooking_hack1))
      # 投稿内容を編集する
      attach_file 'cooking_hack[hack_image]', 'spec/fixtures/test_image2.png'
      fill_in 'repertoire-name', with: @cooking_hack1.title.to_s + '編集済'
      fill_in 'repertoire-comment', with: @cooking_hack1.contents.to_s + '編集済'
      # 編集を投稿してもcooking_hackモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { CookingHack.count }.by(0)
      # 編集が完了し詳細画面に遷移したことを確認する
      expect(current_path).to eq(cooking_hack_path(@cooking_hack1))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の投稿が存在することを確認する（画像）
      expect(page).to have_selector "img[src$='test_image2.png']"
      # トップページには先ほど変更した内容の投稿が存在することを確認する（テキスト）
      expect(page).to have_content(@cooking_hack1.title.to_s + '編集済')
    end
  end

  context '時短裏技の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した時短裏技の編集画面には遷移できない' do
      # 時短裏技1を投稿したユーザーでログインする
      sign_in(@cooking_hack1.user)
      # 時短裏技2の詳細ページに編集ボタンがないことを確認する
      visit cooking_hack_path(@cooking_hack2)
      expect(page).to have_no_link 'この投稿を編集', href: edit_cooking_hack_path(@cooking_hack2)
    end
    it 'ログインしていないと時短裏技の編集画面には遷移できない' do
      # 時短裏技1の詳細ページに遷移する
      visit cooking_hack_path(@cooking_hack1)
      # 時短裏技1の詳細ページに編集ボタンがないことを確認する
      expect(page).to have_no_link 'この投稿を編集', href: edit_cooking_hack_path(@cooking_hack1)
      # 時短裏技2の詳細ページに遷移する
      visit cooking_hack_path(@cooking_hack2)
      # 時短裏技2の詳細ページに編集ボタンがないことを確認する
      expect(page).to have_no_link 'この投稿を編集', href: edit_cooking_hack_path(@cooking_hack2)
    end
  end
end

RSpec.describe '時短裏技の削除', type: :system do
  before do
    @cooking_hack1 = FactoryBot.create(:cooking_hack)
    @cooking_hack2 = FactoryBot.create(:cooking_hack)
  end

  context '投稿した時短裏技が削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した時短裏技の削除ができる' do
      # 時短裏技1を投稿したユーザーでログインする
      sign_in(@cooking_hack1.user)
      # 時短裏技1の詳細ページに遷移する
      visit cooking_hack_path(@cooking_hack1)
      # 時短裏技1の詳細ページに削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        find('.repertoire-destroy').click
      end.to change { CookingHack.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには時短裏技1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector "img[src$='test_image.png']"
    end
  end
  context '時短裏技の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した時短裏技の削除ができない' do
      # 時短裏技1を投稿したユーザーでログインする
      sign_in(@cooking_hack1.user)
      # 時短裏技2の詳細ページに遷移する
      visit cooking_hack_path(@cooking_hack2)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('.repertoire-destroy')
    end
    it 'ログインしていないと時短裏技の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 時短裏技1の詳細ページに遷移する
      visit cooking_hack_path(@cooking_hack1)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('.repertoire-destroy')
      # 時短裏技2の詳細ページに遷移する
      visit cooking_hack_path(@cooking_hack2)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('.repertoire-destroy')
    end
  end
end
