class PublishFeedsController < ApplicationController

  def index
    user = client.selection.me.info!
    client.selection.user(user[:id]).feed.publish!(:message => 'hey, I just uploaded a video to DC3 app' , :name => 'test name')
  end
end