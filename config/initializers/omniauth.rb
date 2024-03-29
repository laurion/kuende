Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :fields => [:email], on_failed_registration: lambda { |env|    
    IdentitiesController.action(:new).call(env)
  }
end