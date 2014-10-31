class SectionDeclarationsController < ApplicationController

 def index
  @sections = SectionDeclaration.all 
 end
 
 def new
  @section = SectionDeclaration.new
 end
 
 def create
  @section = SectionDeclaration.create(section_declaration_params)
  redirect_to  section_declarations_path 
 end
 
 def edit
   @section = SectionDeclaration.find(params[:id])
 end
 
 def update
  @section = SectionDeclaration.find(params[:id])
  @section.update(section_declaration_params)
  redirect_to  section_declarations_path
 end
 
 private 
 
 def section_declaration_params
   params.require(:section_declaration).permit(:section, :maximum_limit) 
 end
 
 
end
