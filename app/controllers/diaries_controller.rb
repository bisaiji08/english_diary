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
      redirect_to diaries_path, notice: "Created"
    else
      render 'new'
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path, notice: "Deleted", status: :see_other
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_parameter)
      @diary.update(updated_at: Time.current)
      redirect_to diaries_path, notice: "Edited"
    else
      render 'edit'
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

  private

  def diary_parameter
    params.require(:diary).permit(:title, :content_japanese, :content_english)
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
        "翻訳エラー: 不正なレスポンスです"
      end
    else
      "翻訳エラー: #{res.body}"
    end
  rescue StandardError => e
    "翻訳エラー: #{e.message}"
  end
end
