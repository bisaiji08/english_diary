class PagesController < ApplicationController
  def terms
  end

  def privacy
  end

  def contact
    if request.post?
      # フォームデータを取得
      name = params[:name]
      email = params[:email]
      message = params[:message]

      # 簡易的にログに出力（本番ではメール送信やDB保存）
      Rails.logger.info "Your inquiry has been sent: #{name}, #{email}, #{message}"

      # 成功メッセージを表示
      flash[:notice] = "Your inquiry has been sent."
      redirect_to contact_path
    end
  end
end
