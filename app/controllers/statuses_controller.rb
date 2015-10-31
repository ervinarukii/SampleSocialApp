class StatusesController < ApplicationController
  before_action :set_status, except: [:index, :new, :create]
  before_action :authenticate_user!, except: :show

  respond_to :html

  def index
    @statuses = Status.all
    respond_with(@statuses)
  end

  def show
    @root_comments = @status.root_comments.order(created_at: :desc).page(params[:page]).per(10)
    respond_with(@status)
  end

  def new
    @status = Status.new
    respond_with(@status)
  end

  def edit
  end

  def create
    @status = current_user.statuses.new(status_params)
    @status.save

    redirect_to root_path, notice: "Status updated"
  end

  def update
    @status.update(status_params)
    respond_with(@status)
  end

  def destroy
    @status.destroy
    respond_with(@status)
  end

  def comment
    @comment = Comment.build_from( @status, current_user.id, params[:body] )
    @comment.save
    @comment.move_to_child_of(params[:comment]) if params[:comment].present? 

    redirect_to status_path(@status), notice: "Successfully created comment"
  end

  def like
    unless params[:comment].present?
      @status.liked_by current_user
    else
      comment = @status.comments.find(params[:comment])
      comment.liked_by current_user
    end

    redirect_to status_path(@status), notice: "You liked this status"
  end

  def unlike
    unless params[:comment].present?
      @status.unliked_by current_user
    else
      comment = @status.comments.find(params[:comment])
      comment.unliked_by current_user
    end

    redirect_to status_path(@status), notice: "You unliked this status"
  end

  private
    def set_status
      @status = Status.find(params[:id])
    end

    def status_params
      params.require(:status).permit(:body, :user_id)
    end
end
