class PlansController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      flash[:success] = '新たな旅行を登録しました。'
      redirect_to root_url
    else
      @plans = current_user.plans.order(id: :desc).page(params[:page])
      flash.now[:danger] = '新たな旅行の登録に失敗しました。'
      render 'plans/new'
    end
  end
  
  def show
    travel_period
    out_of_period
  end
  
  def edit
    
  end

  def update
    if @plan.update(plan_params)
      flash[:success] = 'イベントは正常に更新されました'
      redirect_to @plan
    else
      flash.now[:danger] = 'イベントは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @plan.destroy
    flash[:success] = '旅行の計画を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def plan_params
    params.require(:plan).permit(:destination, :departure_date, :return_date)
  end
  
  def correct_user
    @plan = current_user.plans.find_by(id: params[:id])
    unless @plan
      redirect_to root_url
    end
  end

  def travel_period
    @departure = @plan.departure_date
    @return = @plan.return_date
    @travel_period = (@return - @departure).to_i
    @date = []
    while @departure <= @return do
      @date.push(@departure)
      @departure += 1
    end
  end
  
  def out_of_period
    @events = @plan.events.order(start_time: :asc).page(params[:page])
    @out_date = []
    @events.each do |event| 
      if event.date < @plan.departure_date || event.date > @plan.return_date
        @out_date.push(event.date)
      end
    end
    @out_date_uniq = @out_date.uniq
  end
  
end
