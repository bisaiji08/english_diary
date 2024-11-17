class TreesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tree = Tree.first
  end

  def create
    @tree = Tree.create(name: "Tree1")
    redirect_to mypages_top_path
  end

  def train
    @tree = current_user.tree
  
    if @tree.nil?
      redirect_to mypages_top_path, alert: 'ツリーが作成されていません。'
      return
    end
  
    if @tree.can_train?
      @tree.train!  # 特訓を実行
      redirect_to mypages_top_path, notice: '特訓が完了しました。'
    else
      redirect_to mypages_top_path, alert: '今日はもう特訓はできません。'
    end
  end
end
