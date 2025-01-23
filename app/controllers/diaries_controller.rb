# frozen_string_literal: true

class DiariesController < ApplicationController
  before_action :authenticate_user!
  def index
    @diaries = current_user.diaries
  end

  def new
    @diary = current_user.diaries.build(
      japanese_font_name: 'Noto Sans JP', # デフォルト日本語フォント
      english_font_name: 'Noto Sans' # デフォルト英語フォント
    )
  end

  def show
    @diary = current_user.diaries.find(params[:id])
  end

  def create
    @diary = current_user.diaries.build(diary_parameter)
    @diary.start_time = Time.current # 現在の時間を設定

    if @diary.save
      tree = current_user.tree
      if tree.nil?
        flash[:alert] = "Diary created, but you don't have a tree to train."
      elsif tree.can_train?
        tree.train! # 特訓を実行
        flash[:notice] = 'Diary created and training completed!'
      else
        flash[:alert] = 'Diary created, but training is already done for today.'
      end

      redirect_to @diary # フラッシュメッセージはそのまま渡される
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @diary = current_user.diaries.find(params[:id])
    @diary.destroy
    redirect_to diaries_path, notice: 'Deleted', status: :see_other
  end

  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  def update
    @diary = current_user.diaries.find(params[:id])
    if @diary.update(diary_parameter)
      @diary.update(updated_at: Time.current)
      redirect_to @diary, notice: 'Diary was successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def translate
    content_japanese = params[:content_japanese]
    if content_japanese.present?
      translation = ja_to_en(content_japanese)
      render json: { translation: translation }
    else
      render json: { translation: nil }, status: :unprocessable_entity
    end
  end

  def search
    query = params[:query]
    if query.present?
      diaries = current_user.diaries.where('title ILIKE ?', "%#{query}%").limit(10)
      render json: diaries.as_json(only: %i[id title created_at])
    else
      render json: []
    end
  end

  private

  def diary_parameter
    params.require(:diary).permit(:title, :content_japanese, :content_english, :font_name, :start_time,
                                  :japanese_font_name, :english_font_name)
  end

  def ja_to_en(text)
    url = URI.parse('https://translation.googleapis.com/language/translate/v2')
    params = {
      q: text,
      source: 'ja',
      target: 'en',
      key: ENV['GOOGLE_CLOUD_API_KEY']
    }
    url.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(url)

    if res.is_a?(Net::HTTPSuccess)
      parsed_response = JSON.parse(res.body)
      if parsed_response['data'] && parsed_response['data']['translations']
        parsed_response['data']['translations'].first['translatedText']
      else
        '翻訳エラー: 不正なレスポンスです'
      end
    else
      "翻訳エラー: #{res.body}"
    end
  rescue StandardError => e
    "翻訳エラー: #{e.message}"
  end
end
