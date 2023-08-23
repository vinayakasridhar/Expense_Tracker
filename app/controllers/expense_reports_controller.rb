class ExpenseReportsController < ApplicationController
  before_action :set_expense_report, only: %i[ show edit update destroy ]
  before_action :check_employement_status, except: %i[seach show index]

  def search
    search_term = params[:search_term].strip.downcase

    if search_term.present?
      @expense_reports = @user.get_expense_reports.joins(:user).where("lower(user.name) LIKE ?", "%#{search_term}")
    else
      @expense_reports = @user.get_expense_reports
    end
  end
  
  # GET /expense_reports or /expense_reports.json
  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @expense_reports = @user.get_expense_reports
    else
      @expense_reports = @user.get_expense_reports
    end
  end

  # GET /expense_reports/1 or /expense_reports/1.json
  def show
  end

  # GET /expense_reports/new
  def new
    @expense_report = ExpenseReport.new
    @expense_report.user = @user #associating the user of the report to the current user
  end

  # GET /expense_reports/1/edit
  def edit
  end

  # POST /expense_reports or /expense_reports.json
  def create
    @expense_report = ExpenseReport.new(expense_report_params)
    @expense_report.user = @user #associating the user of the report to the current user

  respond_to do |format|
    if @expense_report.save
      selected_expense_ids = params[:expense_report][:selected_expense_ids] || []
      Expense.where(id: selected_expense_ids).update_all(expense_report_id: @expense_report.id)

      format.html { redirect_to expense_report_url(@expense_report), notice: "Expense report was successfully created." }
      format.json { render :show, status: :created, location: @expense_report }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @expense_report.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /expense_reports/1 or /expense_reports/1.json
  def update
    previously_selected_expenses = @expense_report.expenses

    selected_expense_ids = params[:expense_report][:selected_expense_ids]
    if selected_expense_ids.present?
      expenses = @user.expenses.where(approval_status: "pending", expense_report_id: [nil ,@expense_report.id]).where(id: selected_expense_ids)
      expenses.update_all(expense_report_id: @expense_report.id)
    end
    respond_to do |format|
      if @expense_report.update(expense_report_params)

        currently_selected_expense_ids = params[:expense_report][:selected_expense_ids] || []
        unselected_expenses = previously_selected_expenses.where.not(id: currently_selected_expense_ids)
        unselected_expenses.update_all(expense_report_id: nil)

        format.html { redirect_to expense_report_url(@expense_report), notice: "Expense report was successfully updated." }
        format.json { render :show, status: :ok, location: @expense_report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_reports/1 or /expense_reports/1.json
  def destroy
    @expense_report.destroy

    respond_to do |format|
      format.html { redirect_to expense_reports_url, notice: "Expense report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_report
      @expense_report = ExpenseReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_report_params
      params.require(:expense_report).permit(:title, :total_amount,selected_expense_ids: [])
    end
end
