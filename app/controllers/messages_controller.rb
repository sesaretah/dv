class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :delete, :reply, :reply_all]

  def reply

  end

  def reply_all
    @recipients = params[:recipients].tr('[]', '')
  end
  # GET /messages
  # GET /messages.json
  def index
    @type = params[:type]
    @per_page = 7
    if !params[:page].blank?
      @page = params[:page]
    else
      @page = 1
    end
    @sent_count =  Message.where('sender_id = ? AND status != 2', current_user.id).count
    @inbox_count = Messaging.where("recipient_id = ? AND status = 0", current_user.id).count
    case @type
    when 'sent'
      @messages = Message.where('sender_id = ? AND status != 2', current_user.id).order('created_at DESC').paginate(:page => @page, :per_page => @per_page)
    else
      @messages = Message.joins(:messagings).where("messagings.recipient_id = ? AND messages.status != 2", current_user.id).order('created_at DESC').paginate(:page => @page, :per_page => @per_page)
    end
    @grouped = @messages.to_a.group_by { |t| t.parent }
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @messaging =  @message.messagings.where(recipient_id: current_user.id).first
    if !@messaging.blank?
      @messaging.status = 1
      @messaging.save
    end
    @children =  Messaging.where('message_id in (?) AND recipient_id = ?', @message.children.pluck(:id), current_user.id)
    for child in @children
      child.status = 1
      child.save
    end
    if !params[:page].blank?
      @page = params[:page]
    else
      @page = 1
    end
    if !params[:type].blank?
      @type = params[:type]
    else
      @type = 'inbox'
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @message.status = 1
    respond_to do |format|
      if @message.save
        if !params[:recipients].blank?
          @recipients = params[:recipients].split(',').uniq - [""]
        else
          @recipients = @message.parent.recipients.pluck(:id).uniq + [@message.parent.sender.id]
        end
        for recipient in @recipients
          @recipient = User.find_by_id(recipient)
          if !@recipient.blank? && @recipient.id != current_user.id
            @messaging = Messaging.create(recipient_id: @recipient.id, message_id: @message.id, status: 0)
          end
        end

        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
        format.js
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete
    if @message.sender.id == current_user.id
      @message.status = 2
      @message.save
    end
    for m in  Messaging.where('message_id in (?) AND recipient_id = ?', @message.children.pluck(:id), current_user.id)
      m.status = 2
      m.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :body, :sender_id, :urgency, :parent_id)
    end
end
