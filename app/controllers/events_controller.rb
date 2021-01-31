class EventsController < ApplicationController
  before_action :require_user_logged_in
  
  
  def index
    @plan = Plan.find(params[:id])
    @events = @plan.events.order(id: :desc).page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
    
  end

  def new
    @event = Event.new
  end

  def create
    @plan = Plan.find(params[:id])
    @event = @plan.events.build(event_params)
    if @event.save
      flash[:success] = '新たなイベントを登録しました。'
      redirect_to root_url
    else
     @events = @plan.events.order(id: :desc).page(params[:page])
      flash.now[:danger] = '新たなイベントの登録に失敗しました。'
      render 'events/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def event_params
    params.require(:event).permit(:event_title, :start_time, :end_time, :tel, :url, :address, :budget, :memo)
  end
end
