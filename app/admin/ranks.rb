ActiveAdmin.register Rank do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :permission, :created_at
form :html => {:multipart => true} do |f|
    f.inputs do
      f.input :created_at
      f.input :permission
    end
    f.actions
  end
  
end