class PlansController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

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

  def destroy
    @plan.destroy
    flash[:success] = '旅行の計画を削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def plan_params
    params.require(:plan).permit(:destination)
  end
  
  def correct_user
    @plan = current_user.plans.find_by(id: params[:id])
    unless @plan
      redirect_to root_url
    end
  end
end
