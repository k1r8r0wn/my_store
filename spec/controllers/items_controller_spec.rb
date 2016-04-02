require 'rails_helper'

describe ItemsController, type: :controller do

  describe 'show action' do

    it 'renders show template if an item is found' do
      item = create(:item)
      get :show, id: item.id
      expect(response).to render_template('show')
    end

    it 'renders 404 page if an item is not found' do
      get :show, id: 0
      expect(response.status).to eq(404)
    end

  end

  describe 'create action' do

    it 'redirects to item path if validations pass' do
      post :create, item: { name: 'Item 1', price: '10' }, admin: 1
      expect(response).to redirect_to(item_path(assigns(:item)))
    end

    it 'renders new page again if validations fail' do
      post :create, item: { name: 'Item 1', price: nil }, admin: 1
      expect(response).to render_template('new')
    end

    it 'renders 403 page if user is not admin' do
      post :create, item: { name: 'Item 1', price: nil }
      expect(response.status).to eq(403)
    end

  end

end
