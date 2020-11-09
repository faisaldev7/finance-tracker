class UserStocksController < ApplicationController

  def create
    stock= check_db(params[:ticker])
    if stock.blank?
      stock= Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock= UserStock.create(user: current_user, stock: stock)
    flash[:notice]= "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path

  end

  def check_db(ticker_symbol)
   Stock.where(ticker: ticker_symbol).first
  end

end
