# -*- encoding: utf-8 -*-

require 'rails_helper'

describe MembersController do

  describe 'GET index' do
    it 'works' do
      get :index, {format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'works' do
      post :create, {user: {email: 'test@mailinator.com', password: 'secret'}, format: :json}, {}
      @id = response.id
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    it 'works' do
      get :show, {id: @id, format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT update' do
    it 'works' do
      put :update, {id: @id, user: {id: @id, email: 'test2@mailinator.com', password: 'secret'}, format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE destroy' do
    it 'works' do
      delete :destroy, {id: @id, format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

end
