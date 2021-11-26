ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :prefecture_id, :title, :text, :post_image_id, :address
  #
  # or
  #
  # permit_params do
  #   permitted = [:prefecture_id, :title, :text, :post_image_id, :address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
