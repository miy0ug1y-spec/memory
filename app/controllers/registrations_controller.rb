class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  
  def new
  end

  def create
  end
end
