class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to Lush Bull City!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :organization, :address_line_1, :address_line_2, :city, :zip_code, :password, :password_confirmation)
    end
end
