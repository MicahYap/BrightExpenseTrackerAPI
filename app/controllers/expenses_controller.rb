class ExpensesController < ApplicationController
  before_action :current_user

  def index
    month = params[:month]&.to_i || Date.today.month
    year = params[:year]&.to_i || Date.today.year

    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month
    @expenses = @current_user.expenses.where(date: start_date..end_date)
      .page(params[:page])
      .per(params[:per_page] || 10)

    total_pages = @expenses.total_pages
    total_expense_per_month = @current_user.expenses.where(date: start_date..end_date).sum(:amount)
    render json: {
      expenses: @expenses.map { |expense| 
        {
          id: expense.id,
          category_name: expense.category_name,
          item: expense.item,
          description: expense.description,
          amount: expense.amount,
          date: expense.date
        }
      },
      total_pages: total_pages,
      total_expense_per_month: total_expense_per_month
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
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
 
  end
  
  def update
   
  end

  def destroy
    @expense = Expense.find(params[:id])

    if @expense.destroy
      render json: { message: 'Expense deleted successfully.' }, status: :ok 
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  private

  def current_user
    @current_user = User.find(session[:user_id] || params[:user_id])
    unless @current_user
      render json: { error: "User not found or unauthorized" }, status: :unauthorized
    end
  end

  def expense_params
    params.require(:expense).permit(:category_name, :item, :description, :amount, :date)
  end
end
