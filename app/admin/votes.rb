ActiveAdmin.register Vote do
  index do
    column "Video" do |video|
      video.id
    end
  end
end
