# frozen_string_literal: true

class PagesController < ApplicationController
  def terms; end

  def privacy; end

  def contact
    return unless request.post?

    name = params[:name]
    email = params[:email]
    message = params[:message]

    Rails.logger.info t('pages.contact.log', name: name, email: email, message: message)

    flash[:notice] = t('pages.contact.success')
    redirect_to contact_path
  end
end
