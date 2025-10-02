Lookbook.configure do |config|
  engine_assets_path = Pathname.new(__dir__).join('../../../app/assets').to_s
  config.listen_paths = [engine_assets_path]
end
