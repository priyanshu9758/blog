class AccountsController < ApplicationController
  def index
    @accounts=Account.all
    @accounts = Account.order("created_at DESC")
    respond_to do |f|
      f.html

      f.xlsx
    end
  end


  def import
    skip = true
    CSV.foreach(params[:file].path, headers: false) do|row|
      unless skip
        accessible_attr = %w[ first_name last_name email Phone_number password password_confirmation  ]
        hash = Hash[accessible_attr.zip(row)]
        CsvUploadWorker.perform_async(hash)
      end
      skip = false
    end
    # Account.import(params[:file])
    redirect_to root_path, notice: "Accounts imported."
  end
  def export_all
    @accounts=Account.all
    respond_to do |f|
      f.html
      f.csv {send_data @accounts.to_csv}
       f.xlsx
    end
  end
  def export
    @account=Account.all
    respond_to do |f|
      f.html
      f.csv {send_data @account.to_csv_limited}
      f.xlsx

    end
  end

  def create
    @account=Account.new(account_params)
    @account.add_role params[:roles]
    @account.save
    if @account.save
       # AccountMailer.with(account: current_account).account_created.deliver_later

      redirect_to root_url
    else
      redirect_to create_acc_url
    end
  end
  def reports

  end
  def upload

  end
  def new

  end
  # def show
  #   @accounts = account.find (params_id)
  # end
  def edit

  end
  def activate
      @account=Account.find(params[:id])
      if @account.hidden==true
        @account.hidden=false
        @account.unlock_access!
      else
        @account.hidden=true
        @account.lock_access!
      end
      @account.save
      redirect_to accounts_url
    end

  def account_params
    params.permit(:first_name, :last_name, :email, :Phone_number, :password, :password_confirmation)
  end

  end
