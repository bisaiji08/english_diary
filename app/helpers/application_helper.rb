# frozen_string_literal: true

module ApplicationHelper
  def google_connected?
    current_user.provider.present? && current_user.uid.present?
  end
end
