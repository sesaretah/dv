class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]

  def mergerer

  end

  def merge
    @keyword_1 = Keyword.find(params[:keyword_1])
    @keyword_2 = Keyword.find(params[:keyword_2])
    Keyword.merge_keyword(@keyword_1, @keyword_2)
    redirect_to '/keywords'
  end

  def uniqify
    for keyword in Keyword.all
      for other in Keyword.where('id <> ?', keyword.id)
        if keyword.title == other.title
          taggings = Tagging.where(taggable_type: 'Article', target_type: 'Keyword', target_id: other.id)
          for tagging in taggings
            tagging.target_id = keyword.id
            tagging.save
          end 
          #other.destroy
        end
      end
    end
  end
  def search
    if !params[:q].blank?
      @keyword = Keyword.search params[:q], :star => true
    end
    resp = []
    for k in @keyword
      resp << {'title' => k.title, 'id' => k.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /keywords
  # GET /keywords.json
  def index
    @keywords = Keyword.all.order("title asc").paginate(:page => params[:page], :per_page => 30)
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(keyword_params)
    @keyword.user_id = current_user.id
    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, notice: 'Keyword was successfully created.' }
        format.json { render :show, status: :created, location: @keyword }
      else
        format.html { render :new }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keywords/1
  # PATCH/PUT /keywords/1.json
  def update
    @keyword.user_id = current_user.id
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword }
      else
        format.html { render :edit }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    @keyword.destroy
    respond_to do |format|
      format.html { redirect_to keywords_url, notice: 'Keyword was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_keywords", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_params
      params.require(:keyword).permit(:title, :description)
    end
end
