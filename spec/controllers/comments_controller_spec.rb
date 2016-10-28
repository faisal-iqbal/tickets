# -*- encoding: utf-8 -*-

require 'rails_helper'

describe CommentsController do

  describe 'GET index' do
    it 'works' do
      get :index, {format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'works' do
      post :create, {comment: {body: 'Testing'}, format: :json}, {}
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
      put :update, {id: @id, comment:{body: 'Testing2'}, format: :json}, {}
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
