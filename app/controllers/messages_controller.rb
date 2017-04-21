class MessagesController < ApplicationController
  def index
    # レコードの一覧表示
    @messages = Message.all
    # インスタンス変数を経由することで Controller から View へ変数を渡すことができます。
  end

  def show
    @message = Message.find(params[:id])
    # index アクションのときは Message.all でレコード全てを取得していましたが、今回は id が指定されているので、 Message.find(params[:id]) によって1つだけ取得します。そのため、 @message 変数も単数形の命名にしています。GETメソッドやPOSTメソッドなどや、URL のパラメータやデータは全て params に代入されて受け取れます。
  end

  def new
     @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @message
      # redirect_to はリンク先を指定して強制的に飛ばすメソッドです。ここでは、リンク先は @message となっていて、これは link_to と同様で、@message の show ルーティング(message/:id)に飛ばします。
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      #
      render :new
      # render
      # 8.7理解度低い
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
     @message = Message.find(params[:id])

    if @message.update(message_params)
      #p flash
      #raise
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
    # 今まで prefix_path でしたが、リダイレクトの場合だけは prefix_url とすると決まっています。messages_url は Prefix が messages なので index へリダイレクトされます。リダイレクトのときだけ _url を使用しましょう。
  end
  
  private

  # Strong Parameter
  def message_params
    params.require(:message).permit(:content, :title)
  end
  #new から create へ送られてきたフォームの内容は params[:message] に入っています。しかし、 params[:message] をそのまま使用するのは、セキュリティの観点から推奨されません。直接 params[:message] を扱うのではなく、Strong Parameter（ストロングパラメータ）というフィルタを使用します。

end
