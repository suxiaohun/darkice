class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  layout 'question'

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end


  def run_in_order
    init_order_ids
    if session[:order_ids].size==0
      @question=nil
    else
      @question = Question.find(session[:order_ids].shift)
    end
  end

  def run_in_random
    init_rand_ids
    if session[:rand_ids].size==0
      @question=nil
    else
      id = session[:rand_ids].sample
      session[:rand_ids].delete(id)
      @question = Question.find(id)
    end
  end

  def refresh_ids
    session[:order_ids]=nil
    session[:rand_ids]=nil
    redirect_to questions_path
  end

  # GET /questions/1 or /questions/1.json
  def show
  end


  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to new_question_path, notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy!

    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def init_order_ids
    if session[:order_ids].nil?
      session[:order_ids]= Question.all.pluck(:id)
    end
  end
  def init_rand_ids
    if session[:rand_ids].nil?
      session[:rand_ids]= Question.where(mode: "sqsk").pluck(:id)
    end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :options, :mode, :answer,:explain)
    end
end
