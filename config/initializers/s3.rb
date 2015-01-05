CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAJQSBZ6WXQZHS3O7Q',
      :aws_secret_access_key  => '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'
      # :region                 => ENV['S3_REGION'] # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = 'amzur-hrms'
  config.storage = :fog
  config.fog_public = true
end
