class HoldsController < ApplicationController
  before_action :set_hold, only: %i[ show edit update destroy ]
  before_action :check_max

  # GET /holds or /holds.json
  def index
    @holds = Hold.all
  end

  # GET /holds/1 or /holds/1.json
  def show
  end

  # GET /holds/new
  def new
    @hold = Hold.new
  end

  # GET /holds/1/edit
  def edit
  end

  # POST /holds or /holds.json
  def create
    @hold = Hold.new(hold_params)

    respond_to do |format|
      if @hold.save
        format.html { redirect_to @hold, notice: "Hold was successfully created." }
        format.json { render :show, status: :created, location: @hold }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hold.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holds/1 or /holds/1.json
  def update
    respond_to do |format|
      if @hold.update(hold_params)
        format.html { redirect_to @hold, notice: "Hold was successfully updated." }
        format.json { render :show, status: :ok, location: @hold }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hold.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holds/1 or /holds/1.json
  def destroy
    @hold.destroy
    respond_to do |format|
      format.html { redirect_to holds_url, notice: "Hold was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # submit vs cancel submit
  def submit
    #translate all with user_id to new fields in corresponding tables based on type column
    @holds = Hold.where(user_id: params[:hold][:id])
    @holds.each do |hold|
      if(hold.type == "Rp") # Representative
        #representative_params = ?
        @representative = Representative.new(representative_params)
        @representative.save
      elsif (hold.type == "S") # Student
        @student = Student.new(student_params)
        @student.save
      elsif (hold.type == "Rs") # Response
        @response = Response.new(student_params)
        @response.save
      end
    end
  end

  def cancel_submit
    # delete all rows with user_id
    @holds = Hold.where(user_id: params[:hold][:id])
    @holds.each do |hold|
      hold.destroy
    end
    redirect_to root_path, notice: "Submission cancelled." # redirects to landing page
  end

  # alerts if submission for university made during session
  def check_change
    if(University.find_by(id: @hold.university_id) == nil) # university no longer exists
      uni_deleted_hold_path
    end
    else
      @university = University.where(id: @hold.university_id)
      @students = Student.where(university_id: @gold.university_id)
      num_students = 0 # number students currently in university
      @students.each do |student|
        num_students = num_students + 1
      end

      if (@university.max_limit != @hold.max_limit) # admin changed limit for university
        changed_max_hold_path
      end
      if (num_students != @hold.max_limit) # new submission made
        new_submission_hold_path
      end
    end
  end

  def new_submission
    # a submission to the university was made during session
    @university = University.where(id: @hold.university_id)
    @students = Student.where(university_id: @gold.university_id)
    num_students = 0 # number students currently in university
    @students.each do |student|
      num_students = num_students + 1
    end
    @hold_rep = Hold.find_by(user_id: @hold.user_id, type: "Rp")
    @representative = Representative.find_by(first_name: @hold_rep.first_name, last_name: @hold_rep.last_name, title: @hold_rep.title, university_id: @hold_rep.university_id, rep_email: @hold_rep.rep_email)
    
    if (University.find_by(id: @hold.university_id) == nil) # university does not exist anymore
    elsif (num_students < @hold.curr_students) # admin has deleted some students
      #redirect to previous page? notice: "Some students have been deleted from the university, allowing for more space for nominations" #need to put notice at top of page
    elsif (num_students > @hold.curr_students) && (num_students+@hold.student_num < @hold.max_limit) then # students added, but everything still below limit
      #redirect to previous page? notice: "Some students have been added to the university. The limit has not yet been exceeded but some spaces are now taken." #need to put notice at top of page
    elsif (num_students == @hold.max_limit) # new submission maxed limit
      redirect_to finish_representative_url(@representative), alert: "A submission has been made that used all remaining nominations for the university. We're sorry, but no more nominations are being taken at this time."
    elsif (num_students > @hold.curr_students) && (num_students+@hold.student_num > @hold.max_limit) then # new students submitted and now need to delete some nominations
    end
  end

  def changed_max
    # admin changed university max limit during session
    @university = University.where(id: @hold.university_id)
    @students = Student.where(university_id: @gold.university_id)
    num_students = 0 # number students currently in university
    @students.each do |student|
      num_students = num_students + 1
    end

    if (@university.max_limit > @hold.max_limit) # can add more students
    elsif (@university.max_limit > @hold.max_limit) && (num_students+@hold.student_num < @university.max_limit) then # limit lowered but still within limit
    elsif (num_students == @university.max_limit) # limit lowered to current students
    elsif (num_students > @hold.curr_students) && (num_students+@hold.student_num > @university.max_limit) then # limit lowered and now need to delete some nominations
    end
  end

  def uni_deleted
    # university has been deleted by admin
    redirect_to root_path, alert: "There has been an error in which your university didn't exist. It may be an error or your university may have been deleted. We're sorry, please try again."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hold
      @hold = Hold.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hold_params
      params.require(:hold).permit(:user_id, :type)
    end
end
