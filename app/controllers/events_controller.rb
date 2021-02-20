class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def new
    @event = Event.new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @event = @plan.events.build(event_params)
    if @event.save
      flash[:success] = '新たなイベントを登録しました。'
      redirect_to plan_path(@plan)
    else
     @events = @plan.events.order(id: :desc).page(params[:page])
      flash.now[:danger] = '新たなイベントの登録に失敗しました。'
      render 'events/new'
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = 'イベントは正常に更新されました'
      redirect_to plan_event_url
    else
      flash.now[:danger] = 'イベントは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to plan_path(@plan)
    flash[:success] = '旅行の計画を削除しました。'
  end
  
  private

  def event_params
    params.require(:event).permit(:title, :date, :start_time, :end_time, :tel, :url, :address, :currency, :budget, :memo)
  end
  
  def correct_user
    @event = Event.find(params[:id])
    @plan = current_user.plans.find(params[:plan_id])
    unless @plan
      redirect_to root_url
    end
  end


  
end
