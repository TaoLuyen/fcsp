require "rails_helper"

RSpec.describe Employer::CandidatesController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let(:job){FactoryGirl.create :job}
  let(:group){FactoryGirl.create :group, name: "HR", company_id: company.id}
  let(:group_user){FactoryGirl.create :group_user, user_id: user.id,
    group_id: group.id}
  let(:permission){FactoryGirl.create :permission, entry: "Company",
    optional: {create: true, read: true, update: true, destroy: true},
    group_id: group.id}
  let!(:candidate){FactoryGirl.create :candidate, user_id: 1, job_id: job.id}
  arr_id_success = [1, 2]
  arr_id_fail = [998, 999]

  before :each do
    allow(controller).to receive(:current_user).and_return admin
    sign_in admin
    request.env["HTTP_REFERER"] = "sample_path"
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, params: {company_id: company.id}
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "get candidates of a job successfully" do
      get :index, params: {company_id: company.id, select: job.id}, xhr: true
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "get all candidates of company successfully when params select is empty" do
      get :index, params: {company_id: company.id, select: ""}, xhr: true
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "render template successfully when using xhr request" do
      get :index, params: {company_id: company.id, select: job.id}, xhr: true
      expect(response).to render_template("employer/candidates/_candidate")
    end

    it "get candidates with sort by of a job successfully" do
      get :index, params: {company_id: company.id, select: job.id, sort: "ASC"}, xhr: true
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

  end

  describe "DELETE #destroy" do
    context "delete successfully" do
      before{delete :destroy, params: {company_id: company, ids: arr_id_success}}
      it{expect{response.to change(Candidate, :count).by -1}}
    end

    it "delete fail" do
      allow_any_instance_of(Candidate).to receive(:destroy).and_return(false)
      expect do
        delete :destroy, params: {company_id: company, ids: arr_id_fail}
      end.not_to change(Candidate, :count)
    end

    it "responds successfully with an HTTP 200 status code" do
      delete :destroy, params: {company_id: company, ids: arr_id_success}, xhr: true
      expect(response).to have_http_status 200
    end
  end
end
