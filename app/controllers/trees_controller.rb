# frozen_string_literal: true

class TreesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tree = current_user.tree
  end

  def train
    @tree = current_user.tree

    if @tree.nil?
      redirect_to mypages_top_path, alert: t('trees.train.no_tree')
      return
    end

    if @tree.can_train?
      @tree.train!
      redirect_to mypages_top_path, notice: t('trees.train.success')
    else
      redirect_to mypages_top_path, alert: t('trees.train.already_done')
    end
  end
end
