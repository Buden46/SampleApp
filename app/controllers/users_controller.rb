class UsersController < ApplicationController
  before_filter :load_user, only: [:update, :edit, :show, :destroy]

  def index
    page = params[:page] || 0
    per_page = 5 # paginating user by giving 10 users at a time

    @users = User.page(page).per(per_page).order('updated_at desc')

    @total_count = @users.total_count

    respond_to do |format|
      format.html { @users }
      format.json {
        render json: { status: 200, users: @users }
      }
    end
  end

  def create
    Rails.logger.info "params for creating user is #{params[:user]}"
    @user = User.new(params[:user])
    result = @user.save
    if result
      flash[:success] = "User created successfully"
      respond_to do |format|
        format.html { render '/users/show' }
        format.json {
          render json: { user: @user, status: 201 }
        }
      end
    else
      flash[:error] = @user.errors.full_messages
      respond_to do |format|
        format.html { render '/users/create_user' }
        format.json {
          render json: { errors: @user.errors.full_messages, status: 400 }
        }
      end
    end
  end

  def show
    if @user.present?
      respond_to do |format|
        format.html { render '/users/show' }
        format.json {
          render json: { user: @user, status: 200 }
        }
      end
    else
      respond_to do |format|
        format.html { render '/users/show' }
        format.json {
          render json: { status: 404, errors: ['User not found'] }
        }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/users' }
      format.json {
        render json: { status: 200 }
      }
    end
  end

  def update
    result = @user.update_attributes(params[:user])

    if result
      flash[:success] = "User updated successfully"

      respond_to do |format|
        format.html { render '/users/show' }
        format.json {
          render json: { user: @user, status: 200 }
        }
      end
    else
      flash[:error] = @user.errors.full_messages

      respond_to do |format|
        format.html { render '/users/edit' }
        format.json {
          render json: { errors: @user.errors.full_messages, status: 400 }
        }
      end
    end
  end

  def search
    page = params[:page] || 1
    per_page = 5
    @users = User.where(
      "name LIKE ? or hobbies LIKE ?",
    "%#{params[:user][:search]}%",
      "%#{params[:user][:search]}%"
    ).page(page).per(per_page).order('updated_at desc')

    if @users.present?
      @number_of_pages = (@users.total_count / per_page).to_i

      respond_to do |format|
        format.html { render '/users/index' }
        format.json {
          render json: { users: @users, status: 200 }
        }
      end
    else
      respond_to do |format|
        format.html { render '/users/search' }
        format.json {
          render json: { users: @users, status: 404 }
        }
      end
    end
  end

  def import_users
    @csv_importer = CsvImporter.new(params[:attachment])
    if @csv_importer.save
      file_path = Rails.env == 'test' ? "#{Rails.root.to_s}/spec/fixtures/sample_csv.csv" :
                                        "#{Rails.root.to_s}/public#{@csv_importer.attachment_url}"
      UserCreateWorker.perform_async(file_path)
      # redirect_to csv_importers_path, notice: "The resume #{@csv_importer.name} has been uploaded."
      respond_to do |format|
        format.html { redirect_to '/users' }
        format.json { render json: { users: @users } }
      end
    else
       redirect_to "/users"
    end
  end

  private

  def load_user
    @user = User.find_by_id(params[:id])
  end
end
