ActiveAdmin.register User do
  permit_params :email, :name

  index do
    selectable_column
    id_column
    column :name
    column :email
    column "Tree Level", sortable: false do |user|
      user.tree&.level || "N/A"
    end
    column "Tree Points", sortable: false do |user|
      user.tree&.points || "N/A"
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :created_at
      row :updated_at
    end

    panel "Tree Information" do
      if user.tree.present?
        attributes_table_for user.tree do
          row :level
          row :points
          row :job
          row :last_trained_at
          row :max_count
        end
      else
        div "This user has no associated tree."
      end
    end

    panel "Purchased Items" do
      table_for user.purchased_items do
        column :name
        column :description
        column :price
        column :created_at
      end
    end
  end

  filter :email
  filter :name
  filter :created_at
end
