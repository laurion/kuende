class IdentitiesController < ApplicationController
  layout false
  
  def new
    @identity = env['omniauth.identity']
  end
end
