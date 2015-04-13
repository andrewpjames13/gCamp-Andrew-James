require 'rails_helper'

describe ProjectsController do
  describe "GET #show" do
    before do
      @project = Project.create(name: "My sweet project")
    end

    context "as an admin" do
      before do
        @admin = User.create(
          first_name: "Arjun",
          last_name: "Sharma",
          email: "blah@example.com",
          password: "password",
          password_confirmation: "password",
          admin: true
        )
        session[:user_id] = @admin.id
      end

      it "allows me to see the project" do
        get :show, id: @project.id

        expect(response).to be_success
      end
    end

    context "as a random person" do
      it "redirects me to the signin" do
        get :show, id: @project.id

        expect(response).to be_redirect
        expect(response).to redirect_to signin_path
      end
    end

    context "does not belog to project" do
      it "redirects me to the projects index" do
        user = User.create(
          first_name: "Andrew",
          last_name: "James",
          email: "blah2@example.com",
          password: "password",
          password_confirmation: "password"
        )
        session[:user_id] = user.id

        get :show, id: @project.id

        expect(response).to be
        expect(response).to redirect_to projects_path
      end
    end
  end
end
