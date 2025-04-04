Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      expose: ['Authorization'], # <--- bu satır önemli!
      methods: [:get, :post, :options, :delete, :put]
  end
end
