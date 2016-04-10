class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :generate_menu

  private

  def render_403
    render file: 'public/403.html', status: 403
  end

  def render_404
    render file: 'public/404.html', status: 404
  end

  def check_if_admin
    render_403 unless params[:admin]
  end

  def generate_menu
    mmmenu do |l1|
      l1.add 'All items', items_path do |l2|
        l2.add 'Category 1', items_path(category: 'category_1'), paths: [[items_path, 'get', {category: 'category_1'}]]
        l2.add 'Category 2', items_path(category: 'category_2'), paths: [[items_path, 'get', {category: 'category_2'}]]
      end
      l1.add 'Cart', root_path
    end
  end

end

