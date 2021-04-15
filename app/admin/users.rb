ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation


  index do
    selectable_column
    id_column
    column :name
    column :email
    column :Tweet_count do |user|
      columns user.tweets.count
    end

    column :like_count do |user|
      columns user.likes.count
    end

    column :retweet_count do |user|
      columns user.retweet_count
    end

    


    #column :Retweet_count do |user|
     # columns user.tweets.pluck(:user_id).compact!.count
    #end
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

 
  

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :name, :avatar_url, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :name, :avatar_url, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
