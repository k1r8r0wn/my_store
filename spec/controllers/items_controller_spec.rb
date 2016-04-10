require 'rails_helper'

describe ItemsController, type: :controller do

  it_renders_404_page_whwn_item_is_not_found :show, :edit, :update, :destroy

  describe 'show action' do

    before(:each) do
      @item = create(:item)
    end

    it 'renders show template if an item is found' do
      get :show, id: @item.id
      expect(response).to render_template('show')
    end

    it 'updates views counter' do
      expect(@item.views.value).to eq(0)
      get :show, id: @item.id
      expect(@item.views.value).to eq(1)
    end

  end

  describe 'create action' do

    it 'redirects to crop image item path if validations pass' do
      post :create, item: { name: 'Item 1', price: '10' }, admin: 1
      expect(response).to redirect_to(crop_image_item_path(assigns(:item)))
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

  describe 'destroy action' do

    it 'redirect to index action when an item is destroyed successfully' do
      item = create(:item)
      delete :destroy, id: item.id, admin: 1
      expect(response).to redirect_to(items_path)
    end

  end

end

