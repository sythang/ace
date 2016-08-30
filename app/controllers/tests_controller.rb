class TestsController < ApplicationController
  before_action :set_test, only: [:edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.page(params[:page])
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to tests_path, notice: 'Test was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tests/1
  def update
    if @test.update(test_params)
      redirect_to tests_path, notice: 'Test was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    redirect_to tests_url, notice: 'Test was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.includes(questions: [:options]).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:name, :description, :teacher_id, questions_attributes: [:id, :label, :description, :_destroy, options_attributes: [:id, :content, :_destroy, :is_correct_answer]])
    end
end
