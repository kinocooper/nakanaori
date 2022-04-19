# frozen_string_literal: true

require 'rails_helper'

describe "全体的な画面のテスト" do
  let!(:user) { create(:user,name:'hoge',email:'1@1',password:"kinoko") }

  describe "ログイン画面のテスト" do
    before do
      visit new_user_session_path
    end

    context "表示の確認" do
      it "ページに「ログイン」と表示されているか" do
        expect(page).to have_content "ログイン"
      end

      it "URLが'/login'であるか" do
        expect(current_path).to eq('/login')
      end

      it "ログイン用フォームが正しいか" do
        expect(page).to have_field "user[email]"
        expect(page).to have_field "user[password]"
        expect(page).to have_button "ログイン"
      end

      it "正しくログインできるか" do
        fill_in "user[email]", with: "1@1"
        fill_in "user[password]", with: "kinoko"
        click_button "ログイン"
        expect(page).to have_content "トップページ"
      end

    end
  end

  # describe "" do

  # end

end