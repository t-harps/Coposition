class Users::ApprovalsController < ApplicationController

  before_action :authenticate_user! 
  before_action :check_user, only: :index

  def new
    puts 'Sup'
    @approval = Approval.new
  end

  def create
    set_approvable
    if @approvable
      if current_user.friend_requests.include?(@approvable)
        Approval.accept(current_user.id, @approvable.id, 'User')
        flash[:notice] = "Friend added."
      elsif @approvable.class.to_s == 'Developer'
        current_user.link_with(@approvable) unless current_user.approve_developer(@approvable)
        flash[:notice] = "Developer added."
      else
        Approval.link(current_user.id, @approvable.id, 'User')
        flash[:alert] = "Friend request sent."
      end
      redirect_to user_approvals_path
    else
      invalid_payload("User/Developer not found", new_user_approval_path) 
    end
  end

  def index
    @approved_devs = current_user.developers
    @friends = current_user.friends
    @friend_requests = current_user.friend_requests
    @pending_friends = current_user.pending_friends
    @pending_approvals = current_user.pending_approvals
    # Redirect if foreign app failed to create a pending approval.
    if @pending_approvals.length == 0 && params[:redirect]
      redirect_to params[:redirect]
    end
  end

  def approve
    @approval = Approval.where(id: params[:id], 
      user: current_user).first
    @approval.approve!
    @approved_devs = current_user.developers
  end

  def reject
    @approval = Approval.where(id: params[:id], 
      user: current_user).first
    @approval.reject!
    @approved_devs = current_user.developers
    render "users/approvals/approve"
  end

  private

    def check_user
      unless current_user?(params[:user_id])
        flash[:notice] = "You are signed in as #{current_user.username}"
        if params[:origin]
          developer = Developer.find_by(api_key: params[:api_key])
          redirect_to developer.redirect_url+"?copo_user=#{current_user.username}"
        else
          redirect_to root_path
        end
      end
    end

    def set_approvable
      if allowed_params[:approvable_type] == 'User'
        @approvable = User.find_by(email: allowed_params[:user])
      else
        @approvable = Developer.find_by(email: allowed_params[:user])
      end
    end

    def allowed_params
      params.require(:approval).permit(:user, :approvable_type)
    end

end
