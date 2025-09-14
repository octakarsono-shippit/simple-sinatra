class MyApp < Sinatra::Base
  get '/' do
    'Hello World'
  end

  get '/hello' do
    'Hello World'
  end

  get '/hello/:name' do
    "Hello #{params[:name]}"
  end
end