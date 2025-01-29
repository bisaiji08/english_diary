module TreesHelper
  def tree_image_path(job)
    image_name = case job
                 when 'Seedlings'
                   'seedlings.jpg'
                 when 'young tree'
                   'young_tree.jpg'
                 when 'mature tree'
                   'mature_tree.jpg'
                 else
                   'default_tree.jpg'
                 end

    # 画像が存在するか確認
    if Rails.application.assets.find_asset(image_name)
      image_name
    else
      'default_tree.jpg'
    end
  end
end
