require 'sinatra'

get '/' do
  'Hello World'
end

get '/hello' do
  'Hello World'
end

get '/hello/:name' do
  "Hello #{params[:name]}"
end

get '/pdfs/label_01.pdf' do
  send_file 'public/assets/pdfs/label_01.pdf'
end
