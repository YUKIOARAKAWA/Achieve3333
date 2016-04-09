require 'rails_helper'

RSpec.describe AboutController, type: :controller do

  describe "GET #conpany_overview" do
    it "returns http success" do
      get :conpany_overview
      expect(response).to have_http_status(:success)
    end
  end

end
