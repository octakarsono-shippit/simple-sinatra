require 'sinatra'
require 'sinatra/base'

class MyApp < Sinatra::Base
  # General configurations for the app
  set :root, File.dirname(__FILE__)
  set :public_folder, File.join(root, 'public')

  # Load routes from separate files
  # Dir[File.join(root, 'routes', '*.rb')].each { |file| require file }
  require_relative 'routes/simple'
  require_relative 'routes/easy_post_api'

  get '/pdfs/label_01.pdf' do
    send_file 'public/assets/pdfs/label_01.pdf'
  end
end
