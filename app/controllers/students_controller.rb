class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    students = Student.all
    render json: students
  end

  def update
    find_student
    @student.update!(student_params)
    render json: student, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue
  end

  def show
    find_student
    render json: @student
  end

  def create
    student = Student.create!(student_params)
    render json: student, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue
  end

  def destroy
    find_student
    @student.destroy
  end

  private

  def find_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end

  def render_not_found_response
    render json: { error: "Student not found" }, status: :not_found
  end
end
