class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :create, :destroy]
  
  

  def show
    @event = Event.find(params[:id])
    @budget = budget
  end

  def new
    @event = Event.new
    @plan = Plan.find(params[:id])
    travel_period
  end

  def create
    @plan = Plan.find(params[:id])
    @event = @plan.events.build(event_params)
    if @event.save
      flash[:success] = '新たなイベントを登録しました。'
      redirect_to plan_path(params[:id])
    else
     @events = @plan.events.order(id: :desc).page(params[:page])
      flash.now[:danger] = '新たなイベントの登録に失敗しました。'
      render 'events/new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    travel_period
    @plan = @event.plan.id
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = 'イベントは正常に更新されました'
      redirect_to @event
    else
      flash.now[:danger] = 'イベントは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @plan = Plan.find(@event.plan.id)
    @event.destroy
    redirect_to plan_path(@plan)
    flash[:success] = '旅行の計画を削除しました。'
  end
  
  private

  def event_params
    params.require(:event).permit(:event_title, :date, :start_time, :end_time, :tel, :url, :address, :budget, :memo)
  end
  
  def budget
    if @event.budget.nil?
      ""
    else
      @event.budget.to_s(:delimited)
    end
  end
  
  def correct_user
    @event = Event.find_by(params[:id])
    @plan = current_user.plans.find_by(id: @event.plan.id)
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
  
end
