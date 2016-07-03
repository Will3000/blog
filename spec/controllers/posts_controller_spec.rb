require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new post instance variable" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end
end
