# -*- encoding: utf-8 -*-

require 'rails_helper'

describe TicketsController do

  describe 'GET index' do
    it 'works' do
      get :index, {format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'works' do
      post :create, {ticket: {title: 'Test'}, format: :json}, {}
      expect(response.status).to eq(201)
    end
  end

  describe 'GET show' do
    it 'send 404' do
      get :show, {id: -1, format: :json}, {}
      expect(response.status).to eq(404)
    end
    
    it 'works' do
      get :show, {id: @id, format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT update' do
    it 'works' do
      put :update, {id: @id, ticket: {id: @id, title: 'Test'}, format: :json}, {}
      @id = response.id
      expect(response.status).to eq(200)
    end
  end

  describe 'POST mark_close' do
    it 'works' do
      post :mark_close, {id: @id, format: :json}, {}
      expect(response.status).to eq(200)
    end
  end

  describe 'POST reopen' do
    it 'works' do
      post :reopen, {id: @id, format: :json}, {}
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
