class MypagesController < ApplicationController
  def top
    @tree = current_user.tree
  end
end
