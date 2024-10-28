class ExpensesController < ApplicationController

  before_action :current_user

  def index
    
    month = params[:month]&.to_i || Date.today.month
    year = params[:year]&.to_i || Date.today.year

    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month
    @expenses = @current_user.expenses.where(date: start_date..end_date)
    @expenses = @expenses.paginate(page: params[:page], per_page: 10)

    render json: @expenses.map { |expense| 
      {
        id: expense.id,
        category: expense.category_id,
        item: expense.item,
        description: expense.description,
        amount: expense.amount
        date: expense.date
      }
    }
    
  end

  def show

  end

  def new
  end

  def create
    @expense = @current_user.expenses.build(expense_params)
    if @expense.save
      render json: @expense, status: :created
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  def edit
  end
  
  def update
  end

  def destroy
    @expense = Expense.find(params[:id])

    if @expense.destroy
      render json: {message: 'Expense deleted successfully.'}, status: :ok 

    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

end

private

def current_user
  @current_user = User.find(session[:user_id]) if session[:user_id]
end

def expense_params
  params.require(:expense).permit(:category_id, :item, :description, :amount, :date)
end
