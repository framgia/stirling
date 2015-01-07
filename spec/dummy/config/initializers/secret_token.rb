if "4.1.0" > Rails.version && Rails.version >= "4.0.0"
  Dummy::Application.config.secret_key_base = "2b8fc4c232d883e0b94b7ec6203bacf50b4a599886263b9c547358598f58c3b6443be29e414d4c7920042f26d899012438cc23537eab4762ae92bb4aaf173afb"
end
