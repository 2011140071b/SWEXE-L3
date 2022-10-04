class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end
  
  def new
    @tweet = Tweet.new
  end
  
  def create
    if params[:tweet][:file]
      file = params[:tweet][:file].read
    else
      file = nil
    end
    @tweet = Tweet.new(message: params[:tweet][:message], tdate: Time.current, file: file)
    if @tweet.save
      flash[:notice] = 'ツイートしました'
      redirect_to root_path
    else
      render tweets_new_path
    end
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path
  end
  
  def show
    @tweet = Tweet.find(params[:id])
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    if params[:tweet][:file]
      file = params[:tweet][:file].read
    else
      file = nil
    end
    tweet.update(message: params[:tweet][:message], file: file)
    redirect_to root_path
  end
  
  def get_image
    tweet = Tweet.find(params[:id])
    send_data tweet.file, disposition: :inline, type: 'image/png'
  end
end
