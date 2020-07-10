class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update
  ]
  
  def index
     @messages = Message.all
  end

  def show
    #set_message
    #@message = Message.find(params[:id])
    # index アクションのときは Message.all でレコード全てを取得していたが、
    #今回は id が指定されているので、
    #Message.find(params[:id]) によって1つだけ取得する
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @message
      #HTTPリクエストを発生させるため、次のページに言っても上のメッセージが消えない、flash[:success]を使用する。
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      #flash.nowは、次のページに行った時点で消えるメッセージ
      render :new
      #render で指定したview を取り出す。
    end
  end

  def edit
    #set_message
    #@message = Message.find(params[:id])
    #params[:id]による検索
  end

  def update
    #set_message
    #@message = Message.find(params[:id])

    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_message
    #@message = Message.find(params[:id])
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end
  
  private
   
  def set_message
     @message - Message.find(params[:id])
  end

  # Strong Parameter
  def message_params
    params.require(:message).permit(:content)
  end
  
end

