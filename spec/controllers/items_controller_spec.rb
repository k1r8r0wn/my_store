require 'rails_helper'

describe ItemsController, type: :controller do

  def self.it_renders_404_page_whwn_item_is_not_found(*actions)
    actions.each do |a|
      it "#{a} renders 404 page when item is not found" do
        verb = if a == :update
                 "PATCH"
               elsif a == :destroy
                 "DELETE"
               else
                 "GET"
               end
        process a, verb, { id: 0 }
        expect(response.status).to eq(404)
      end
    end
  end

  it_renders_404_page_whwn_item_is_not_found :show, :edit, :update, :destroy

  describe 'show action' do

    it 'renders show template if an item is found' do
      item = create(:item)
      get :show, id: item.id
      expect(response).to render_template('show')
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

  describe 'destroy action' do

    it 'redirect to index action when an item is destroyed successfully' do
      item = create(:item)
      delete :destroy, id: item.id, admin: 1
      expect(response).to redirect_to(items_path)
    end

  end

end
