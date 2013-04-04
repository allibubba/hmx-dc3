ActiveAdmin.register Track do
  form do |f|
    
    f.inputs "Status" do
      f.input :title
      f.input :artist_name
      f.input :status,  :as => :select, :collection => ['approved','denied']
    end

    f.inputs "Files/Media" do
         f.input :format_mpeg
         f.input :media
    end
    
    f.buttons
  end  
end
