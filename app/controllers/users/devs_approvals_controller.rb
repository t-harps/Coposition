class Users::DevsApprovalsController < ApplicationController
  before_action :authenticate_user!

  def create
    developer = Developer.find_by(company_name: allowed_params[:approvable])
    approval = Approval.add_developer(current_user, developer) if developer
    if valid_params?(developer, approval)
      @presenter = ::Users::ApprovalsPresenter.new(current_user, 'Developer')
      gon.push(@presenter.gon)
      redirect_to(user_apps_path, notice: 'Developer approved')
    end
  end

  private

  def allowed_params
    params.require(:approval).permit(:approvable, :approvable_type)
  end

  def valid_params?(developer, approval)
    return true if developer && approval.save
    errors = approval ? approval.errors.get(:base).first : 'Developer not found'
    redirect_to new_user_approval_path(approvable_type: 'Developer'), alert: "Error: #{errors}"
    false
  end
end
