class SubjectsController < ApplicationController
layout "admin"

  def index
    @subjects =Subject.sorted
  end

  def show
    @subject=Subject.find(params[:id])
  end

  def new
 @subject=Subject.new({:name => 'Skoglund'})
  end

  def create
   @subject=Subject.new(subject_params)
   if @subject.save
        flash[:notice] = "Subject created succesfully !"
       redirect_to(:action => 'show',:id => @subject.id)
   else
    render('new')
   end
  end

  def edit
    @subject=Subject.find(params[:id])
  end

  def update
    @subject=Subject.find(params[:id])
   if @subject.update_attributes(subject_params)
        flash[:notice] = "Subject updated succesfully !"
       redirect_to(:action => 'show',:id => @subject.id)
   else
    render('edit')
   end
  end

  def delete
    @subject=Subject.find(params[:id])
  end

  def destroy
    # sub = Subject.find(params[:id]).destroy
    # flash[:notice] = "Subject #{sub} deleted succesfully !"
    # redirect_to(:action => 'index')
    @subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject #{@subject.name} deleted succesfully !"
    redirect_to(:action => 'index')
  end
  def toa
     @subject=Subject.find(params[:id])
  end

    private

    def subject_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:subject).permit(:name, :position, :visible)
    end
end
