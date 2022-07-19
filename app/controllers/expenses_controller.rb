class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[destroy]
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
    parameters = params.require(:expense).permit(:name, :amount, selected_groups: [])
    @expense = current_user.expenses.new(name: parameters[:name], amount: parameters[:amount])
    selected_groups = parameters[:selected_groups]
    groups = Group.where(id: selected_groups)
    groups.each do |group|
      @expense.groups.push(group)
    end

    respond_to do |format|
      if @expense.save
        format.html { redirect_to group_expenses_url(groups[0].id), notice: 'Expense was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to group_expenses_url(@group), notice: 'Expense was successfully destroyed.' }
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
end
