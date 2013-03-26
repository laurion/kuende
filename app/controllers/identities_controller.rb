class IdentitiesController < ApplicationController
  layout "landing"
  
  def new
    @identity = env['omniauth.identity']
  end
end
