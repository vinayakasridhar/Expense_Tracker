class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_expense, only: %i[new index create destroy]
  before_action :authenticate_user!, except: [:show , :index]

  # GET /comments or /comments.json
  def index
    @comments = @expense.comments
    @comment = Comment.new
    set_commentable_type
  end

  # GET /comments/1 or /comments/1.json
  def show
    @expense = @comment.expense
  end

  # # GET /comments/new
  def new
    @comment = Comment.new
    set_commentable_type
  end

  # GET /comments/1/edit
  def edit
    @expense = @comment.expense
  end

  # POST /comments or /comments.json
  def create

    @comment = Comment.new(comment_params)
    
    @comment.user = current_user

    set_commentable_type
    if @comment.commentable_type == "Expense"
      respond_to do |format|
        if @comment.save
          format.html { redirect_to expense_comments_url(@comment), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    elsif @comment.commentable_type == "Expense Report"
      respond_to do |format|
        if @comment.save
          format.html { redirect_to expense_report_comments_url(@comment), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to expense_comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to expense_comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_expense
      begin
        @expense = Expense.find(params[:expense_id])  
      rescue => exception
        @expense = ExpenseReport.find(params[:expense_report_id])
      end
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_commentable_type
      begin
        @comment.expense = @expense
        @comment.commentable_type = "Expense"
      rescue => exception
        @comment.expense_report = @expense
        @comment.commentable_type = "Expense Report"
      end
    end
end
