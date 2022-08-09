class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        instructors = Instructor.all 
        render json: instructors 
    end 

    def show
        find_instructor
        render json: @instructor
    end 
    
    def update 
        find_instructor
        @instructor.update!(instructor_params)
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      rescue
    end 

    def destroy
        find_instructor
        @instructor.destroy 
    end 

    def create 
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end 

    private 
    def instructor_params 
        params.permit(:name, :id)
    end 

    def find_instructor 
        @instructor = Instructor.find(params[:id])
    end 

    def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
      end
end
