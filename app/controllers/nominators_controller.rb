class NominatorsController < ApplicationController
  before_action :set_nominator, only: %i[ show edit update destroy ]

  # GET /nominators or /nominators.json
  def index
    @nominators = Nominator.all
  end

  # GET /nominators/1 or /nominators/1.json
  def show
  end

  # GET /nominators/1/user_show
  def user_show
    @nominator = Nominator.find(params[:id])
  end

  # GET /nominators/new
  def new
    @nominator = Nominator.new
  end

  # GET /nominators/user_new
  def user_new
    @nominator = Nominator.new
  end

  # GET /nominators/1/edit
  def edit
  end

  # GET /nominators/1/user_edit
  def user_edit
    @nominator = Nominator.find(params[:id])
  end

  # POST /nominators or /nominators.json
  def create
    @nominator = Nominator.new(nominator_params)

    respond_to do |format|
      if @nominator.save
        format.html { redirect_to nominator_url(@nominator), notice: "Nominator was successfully created." }
        format.json { render :show, status: :created, location: @nominator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nominator.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_create
    @nominator = Nominator.new(nominator_params)

    respond_to do |format|
      if @nominator.save
        format.html { redirect_to user_show_nominator_url(@nominator), notice: "Nominator was successfully created." }
        format.json { render :show, status: :created, location: @nominator }
      else
        format.html { render :user_new, status: :unprocessable_entity }
        format.json { render json: @nominator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nominators/1 or /nominators/1.json
  def update
    respond_to do |format|
      if @nominator.update(nominator_params)
        format.html { redirect_to nominator_url(@nominator), notice: "Nominator was successfully updated." }
        format.json { render :show, status: :ok, location: @nominator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nominator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nominators/1 or /nominators/1.json
  def user_update
    @nominator = Nominator.find(params[:id])

    respond_to do |format|
      if @nominator.update(nominator_params)
        format.html { redirect_to user_show_nominator_url(@nominator), notice: "Nominator was successfully updated." }
        format.json { render :show, status: :ok, location: @nominator }
      else
        format.html { render :user_edit, status: :unprocessable_entity }
        format.json { render json: @nominator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nominators/1 or /nominators/1.json
  def destroy
    @nominator.destroy

    respond_to do |format|
      format.html { redirect_to nominators_url, notice: "Nominator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def finish
    @nominator = Nominator.find(params[:id])
    @students = Student.where(nominator_id: @nominator.id)
    @max_lim = $max_limit
  end

  def nominator_check
    @nominator = Nominator.find(params[:id])
    @university = University.find(@nomresentitive.university_id)

    if @university.num_nominees >= $max_limit
      redirect_to finish_url(@nominator), notice: "Sorry, your university has already reached the maximum limit of 3 student nominees." 
    else
      @student = Student.new
      @student.update(first_name: "", last_name: "", university_id: @nomresentitive.university_id, student_email: "", exchange_term: "", degree_level: "", major: "")
      edit_student_path(@student)
    end
  end

  def test_method
    @nominator.update(first_name: "Updated")
  end

  def nominator_redirect
    user_new_student_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nominator
      @nominator = Nominator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nominator_params
      params.require(:nominator).permit(:first_name, :last_name, :title, :university_id,:nominator_email)
    end
end
