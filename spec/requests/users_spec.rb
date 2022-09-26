# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Sessions" do 
  let(:new_user) { FactoryBot.create(:user)}

  it 'should respond with status 200 when sign in' do
    sign_in new_user
    get root_path
    expect(response).to render_template(:index) 
    expect(response).to have_http_status(200)
  end
  
  it 'should respond with status 302 when sign out' do
    sign_out new_user
    get root_path
    expect(response).not_to render_template(:index) 
    expect(response).to redirect_to(new_user_session_path) 
    expect(response).to have_http_status(302)
  end
  

  it "should be redirected to sign in" do
    get root_path
    expect(response).to redirect_to(new_user_session_path)
  end
  
 
  describe '#edit ' do 
    it 'render :edit' do      
      sign_in new_user
      get edit_user_registration_path, params: {
          id: new_user.id
      }
      expect(response).to render_template(:edit)
    end
  end
end

  describe 'Authentication', type: :request do  
    describe 'POST /auth (Sign Up process)' do
      it 'Should respond with status 200(OK)' do
        post user_registration_path      
        expect(response).to have_http_status(200)
      end 
    end
  end


  describe 'POST /auth/confirmation (Confirmation process)' do
    let(:user) { FactoryBot.create(:user, created_at: nil) }
    it 'Should respond with status 302(URL redirection)' do      
      get root_path
      expect(response).to be_redirect
      expect(response).to have_http_status(302)
    end
  end
