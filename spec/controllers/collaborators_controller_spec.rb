require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do

  describe "GET #_form" do
    it "returns http success" do
      get :_form
      expect(response).to have_http_status(:success)
    end
  end

end
