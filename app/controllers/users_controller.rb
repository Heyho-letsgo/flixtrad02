class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.not_admins
end
=begin
  def index
    @users = User.order("#{params[:sort_param]}")



    #@users = User.all.orderedd
    #@usersn = User.all.ordereda
  end
=end
  def order
  params[:sort_param] = %w{name created_at id}.include?(params[:sort_param]) ? params[:sort_param] : 'id'
  params[:sort_param2] = %w{name created_at id}.include?(params[:sort_param2]) ? params[:sort_param2] : 'id'

  if params[:sort_params]
    @users = User.order "#{params[:sort_param]} ASC"
  else
    params[:sort_params2]
    @users = User.order "#{params[:sort_param2]} DESC"
  end
  end



  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new

    end
  end
  def edit
  #@user = User.find(params[:id])
  end
  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Account successfully updated!'
    else
      render :edit
    end
  end
  def destroy

      @user = User.find(params[:id])
      @user.destroy
     # session[:user_id] = nil # Puisque c'est l'admin qui est connecté
      redirect_to root_url, alert: "Account successfully deleted!"
    end
end

  private
def user_params
  params.require(:user).
      permit(:name, :email, :password, :password_confirmation, :username, :admin)
end
def require_correct_user
  @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end


