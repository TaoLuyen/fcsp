class Employer::JobsController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_company, only: :create
  before_action :load_hiring_types, only: [:create, :new]

  def new
    @job = Job.new
    @job.pictures.build
    #byebug
  end

  def edit
  end

  def show
  end

  def create
    @job = @company.jobs.build job_params
    # @job.build_image #@job = @company.jobs.build job_params
    if params[:public]
      if @job.save
        flash[:success] = t ".created_job"
        redirect_to job_path
      else
        flash[:danger] = t ".create_job_fail"
        redirect_to :back
      end
    elsif params[:preview]
      if @job.save
        byebug
        flash[:success] = t ".created_job"
        redirect_to job_path(@job)
      else
        flash[:danger] = t ".create_job_fail"
        redirect_to :back
      end
    end
  end

  def update
    if @job.update_attributes job_params
      flash[:success] = t ".job_post_updated"
    else
      flash[:danger] = t ".job_post_update_fail"
    end
    redirect_to employer_company_job_path(@company)
  end

  private

  def job_params
  #  byebug
    params.require(:job).permit Job::ATTRIBUTES
  end

  def load_company
    @company = Company.find_by id: params[:company_id]
    not_found unless @company
  end

  def load_hiring_types
    @hiring_types = HiringType.all
  end
end
