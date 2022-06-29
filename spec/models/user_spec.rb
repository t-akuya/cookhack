require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができるとき' do
      it 'フォームが正しく入力されているとき' do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームが入力されていません。')
      end

      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスが入力されていません。')
      end

      it '重複するemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスは既に使用されています。')
      end

      it 'emailに@が含まれていない場合登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは有効でありません。')
      end

      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上に設定して下さい。', 'パスワードは有効でありません。')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end

      it 'passwordに全角が含まれている場合登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end

      it 'passwordがpassword_confirmationと不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'def456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード(確認)が内容とあっていません。')
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('名字が入力されていません。')
      end

      it 'last_nameが全角(漢字、カタカナ、ひらがな)ではない場合登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は有効でありません。')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('名前が入力されていません。')
      end

      it 'first_nameが全角(漢字、カタカナ、ひらがな)ではない場合登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は有効でありません。')
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('名字カナが入力されていません。')
      end

      it 'last_name_kanaが全角(カタカナ)ではない場合登録できない' do
        @user.last_name_kana = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字カナは有効でありません。')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナが入力されていません。')
      end

      it 'first_name_kanaが全角(カタカナ)ではない場合登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナは有効でありません。')
      end

      it 'birth_dayが空では登録できない' do
        @user.birth_day = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日が入力されていません。')
      end
    end
  end
end
