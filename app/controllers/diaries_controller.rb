class DiariesController < ApplicationController
  def index
    @diaries = Diary.all
  end

  def new
    @diary = Diary.new
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def create
    @diary = Diary.new(diary_parameter)
    @diary.start_time = Time.current # 現在の時間を設定
    if @diary.save
      redirect_to diaries_path, notice: "日記を作成しました"
    else
      render 'new'
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path, notice: "削除しました", status: :see_other
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_parameter)
      @diary.update(updated_at: Time.current)
      redirect_to diaries_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def diary_parameter
    params.require(:diary).permit(:title, :content_japanese, :content_english)
  end
end
