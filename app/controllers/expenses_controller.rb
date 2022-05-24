class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ destroy ]
  before_action :set_group

  # GET /expenses 
  def index
    @expenses = @group.expenses
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # POST /expenses 
  def create
    params = expense_params
    @expense = Expense.new(name: params[:name], amount: params[:amount])
    @expense.user_id = current_user.id
    @categories_ids = params[:categories_ids]
    @categories_ids.each do |id|
      category = Category.find(id) unless id == ''
      @expense.categories.push(category) unless category.nil?
    end

    respond_to do |format|
      if @expense.save
        format.html { redirect_to group_expenses_url(@group.id), notice: 'Transaction was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :amount, category_ids: [])
    end
end
