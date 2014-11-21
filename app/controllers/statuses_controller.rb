class StatusesController < ApplicationController
  
  def index 
    #@employee = Employee.find(params[:employee_id])
    @statuses = Status.all
  end
  
  def new
  #raise params.inspect
   @status = Status.new
  end
  
  def create
  @employee = Employee.find(params[:employee_id])
    raise params.inspect
    @status = Status.new(status_params)
      if @status.save          
        
      else
        render "new"
      end
  end


  private
  
  def status_params
    params.require(:status).permit(:status)
  end  
end






















=begin
      
  def new
  #raise params.inspect
  @teacher = Teacher.find(params[:teacher_id])
  @student = Student.new
  end
  
  def create
  @teacher = Teacher.find(params[:teacher_id])
  @student = @teacher.students.create(student_params)
  @student.save
  redirect_to teacher_students_path(@teacher)
  end
  
  def show
  #raise params.inspect
  @teacher = Teacher.find(params[:teacher_id])
  @student = Student.find(params[:id])
  end
  
  def edit
  #raise params.inspect
  @teacher = Teacher.find(params[:teacher_id])
  @student = Student.find(params[:id])
  
  end
  
  def update
  @teacher = Teacher.find(params[:teacher_id])
  @student = Student.find(params[:id])
  @student.update(student_params)
  redirect_to teacher_students_path(@teacher)
  end
  
  def destroy
  @student = Student.find(params[:id])
  @student.destroy
  redirect_to teacher_students_path
  end
   
  private
  
  def student_params
  params.require(:student).permit(:name, :roll, :leave)
  end
  
end
=end
