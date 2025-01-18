ActiveAdmin.register Purchase do
  permit_params :user_id, :item_id

  index do
    selectable_column
    id_column
    column :user
    column :item
    column :created_at
    actions
  end

  filter :user
  filter :item
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :item
    end
    f.actions
  end
end

