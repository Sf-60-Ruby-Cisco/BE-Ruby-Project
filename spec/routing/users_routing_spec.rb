require "rails_helper"

RSpec.describe 'UsersController', type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users").to route_to("devise/registrations#new")
    end

    it "routes to #edit" do
      expect(get: "/users/edit").to route_to("users/registrations#edit")
    end

    it "routes to #new" do
      expect(get: "/users/sign_in").to route_to("devise/sessions#new")
    end
    
    it "routes to #destroy" do
      expect(get: "/users/cancel").to route_to("users/registrations#cancel")
    end
  end
end
