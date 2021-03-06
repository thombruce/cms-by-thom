class Admin::UsersController < AdminController
  before_action :set_workspace
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/users.json
  def index
    @users = policy_scope(@workspace.users)
    authorize User
  end

  # GET /workspaces/:workspace_id/users/:id.json
  def show
  end

  # POST /workspaces/:workspace_id/users/invite.json
  def invite
    if Settings.mailer_configured?
      @user = User.find_or_initialize_by(email: permitted_attributes(User)[:email])
      if @user.new_record?
        @user.regenerate_confirmation_token
        @user.save
      end
    else
      @user = User.find_by(email: permitted_attributes(User)[:email])
    end

    authorize @user

    if @user.add_role(permitted_attributes(User)[:role], @workspace)
      Credible::InvitationMailer.with(user: @user).invitation_email.deliver_later if Settings.mailer_configured? && @user.password_digest.blank?
      render :show, status: :created, location: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  # PATCH /workspaces/:workspace_id/users/:id.json
  def update
    # TODO: There is no method in Rolify to remove all existing roles, or to simply replace
    #       the existing role. This is a hideous workaround. Refactor it.
    @user.remove_role :admin, @workspace
    @user.remove_role :moderator, @workspace
    @user.remove_role :author, @workspace

    if @user.add_role(permitted_attributes(User)[:role], @workspace)
      render :show, status: :created, location: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = @workspace.users.find(params[:id])
      authorize @user
    end
end
