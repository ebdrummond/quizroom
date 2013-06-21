class ClassroomsController < ApplicationController
  respond_to :json, only: :update
  before_filter :validate_access_rights, except: [:new, :create]
  before_filter :is_teacher, only: [:new, :create]

  def show
    @classroom = Classroom.find_by_id(params[:id])
  end

  def create
    @classroom = Classroom.create(teacher_id: current_user.id, name: params[:class_name])
    if @classroom
      redirect_to @classroom
    else
      redirect_to new_classroom_path, notice: "There was a problem creating the clasroom."
    end
  end

  private

  def is_teacher
    redirect_to root_path unless current_user && current_user.teacher?
  end

  def validate_access_rights
    classroom = Classroom.find(params[:id])
    unless classroom.members.include?(current_user)
      redirect_to root_path,
      notice: "You must be logged in and a member of this Quizroom to view this page!"
    end
  end
end
