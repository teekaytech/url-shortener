require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:valid_attributes) { { original:  'https://stackoverflow.com/' } }
  let(:invalid_attributes){ { original:  'hello-world' } }
  let(:link) { LinkShortener.new(url: 'https://stackoverflow.com/').shorten }

  describe 'GET /index' do
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns an instance of Link object' do
      expect(assigns(:link).present?).to be true
    end

    it 'renders index view page' do
      expect(response).to render_template('index')
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      before do
        post :create, params: {link: valid_attributes}, xhr: true, format: :js
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'should create a new link object instance' do
        expect(assigns(:link).persisted?).to be true
      end

      it 'should render create.js' do
        expect(response).to render_template('create')
      end

      it 'should set all available links instance into the links variable' do
        expect(assigns(:links).present?).to be true
        expect(assigns(:links).length).to eq 1
      end
    end

    context 'with invalid attributes' do
      before do
        post :create, params: {link: invalid_attributes}, xhr: true, format: :js
      end

      it 'should not create Link object instance' do
        expect(assigns(:link).persisted?).to be false
      end

      it 'should have error messages to be rendered.' do
        expect(assigns(:link).errors.full_messages.present?).to be true
      end
    end
  end

  describe 'GET /show' do
    context 'when valid parameters are provided' do
      it 'should redirect http status code' do
        get :show, params: { code: link.code }

        expect(response).to have_http_status(:redirect)
      end

      it 'should increment the value of clicks attribute by 1' do
        clicks = link.clicks.to_i
        get :show, params: { code: link.code }
        expect(link.reload.clicks.to_i).to eq(clicks + 1)
        expect(response).to have_http_status(:redirect)
      end

      it 'should get the expected link object' do
        get :show, params: { code: link.code }
        expect(assigns(:link)).to eq link
      end
    end

    context 'when invalid parameters are provided' do
      before do
        get :show, params: { code: '1234' }
      end

      it 'should render 404 page when link is not found' do
        expect(response.body).to include("The page you were looking for doesn't exist.")
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete :destroy, params: { id: link.code }
    end

    it 'delete destroy the link' do
      expect(Link.where(id: link.id).present?).to be false
    end

    it 'should redirect to root path' do
      expect(response).to have_http_status(:redirect)
    end
  end
end
