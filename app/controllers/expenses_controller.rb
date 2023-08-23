class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy approve reject]
  # before_action :check_approval_status, only: %i[approve reject]
  before_action :authenticate_user!, except: [:show , :index]
  before_action :check_employement_status, except: %i[search index show]

  def search
    search_term = params[:search_term].strip.downcase

    if search_term.present?
      # Perform the search using the provided search_term
      @expenses = @user.get_expenses.joins(:user).where("lower(users.name) LIKE ?", "%#{search_term}%")
    else
      # If no search term is provided, display all expenses
      @expenses = @user.get_expenses
    end

    render :index
  end
  
  # GET /expenses or /expenses.json
  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @expenses = @user.get_expenses
    else
      @expenses = @user.get_expenses
    end
  end
  
  def approve
    # Send approval email
    UserMailer.approval_email(@expense).deliver_now
    if @expense.approval_status == "pending"
      @expense.update(approval_status: 'Approved')
      redirect_to expenses_path, notice: 'Expense approved successfully.'
    else
      redirect_to expenses_path, notice: 'Expense is already ' + @expense.approval_status + '.'
    end

  end
  def reject
    # Send rejection email
    UserMailer.rejection_email(@expense).deliver_now
    if @expense.approval_status == "pending"
      @expense.update(approval_status: 'Rejected')
      redirect_to expenses_path, notice: 'Expense rejected successfully.'
    else
      redirect_to expenses_path, notice: 'Expense is already ' + @expense.approval_status + '.'
    end
  end

  # GET /expenses/1 or /expenses/1.json
  def show
    # @expense = Expense.find(params[:id])
    @comments = @expense.comments
    @comment = Comment.new
    @users = User.all
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    respond_to do |format|
      if @expense.save
        # format.html { redirect_to expense_url(@expense), notice: "Expense was successfully created." }
        # format.json { render :show, status: :created, location: @expense }
        validation_result = validate_invoice(@expense.invoice_number)
      
        if validation_result
        # Validation successful, expense needs manual approval
          @expense.update(invoice_validated: validation_result)
          format.html {redirect_to expense_url(@expense), notice: "Expense was successfully created. Pending manual approval."}
        else
        # Validation failed, automatically reject the expense
          format.html {redirect_to new_expense_url(@expense), alert: "Expense validation failed. Expense rejected."}
          @expense.destroy
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # def check_approval_status(@t)
    #   if @t.approval_status == "pending"
    #     return 
    #   end
    # end

    # def set_expenses
    #   if @user.admin
    #     @expenses = Expense.all
    #   else
    #     @expenses = @user.expenses
    #   end
    # end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:date, :description, :amount, :invoice_number, :invoice_validated,:invoice)
    end
end
