ActiveAdmin.register User do
  index do
    column "ID", :id
    column "name", :username
    column "email", :email
    column "Location", :location
    column "Country", :country
    column "Banned", :banned

    default_actions
  end

  form do |f|
    f.inputs "Banned" do
      f.input :banned,  :label => "Is user banned?", :as => :select, :collection => [true, false]
    end
    f.input :fb_id
    f.input :username

    f.buttons
  end
end
