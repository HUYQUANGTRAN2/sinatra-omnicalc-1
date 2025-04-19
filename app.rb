require "sinatra"
require "sinatra/reloader"

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get("/square/new") do
  erb(:square_new)
end

get ("/square/result") do
  if params.key?("input")
    @input = params.fetch("input").to_f
    @output = @input**2
  end
  erb(:square_result)
end

get("/square_root/new") do
  erb(:square_root_new)
end

get("/square_root/result") do
  if params.key?("input")
    @input = params.fetch("input").to_f
    @output = @input**0.5
  end
  erb(:square_root_result)
end

get("/random/new") do
  erb(:random_new)
end

get("/random/result") do
  if params.key?("minimum") && params.key?("maximum")
    @minimum = params.fetch("minimum").to_f
    @maximum = params.fetch("maximum").to_f
    @random_number = rand(@minimum..maximum)
  end
  erb(:random_new_result)
end

get("/payment/new") do
  erb(:payment)
end

get("/payment/result") do
  if params.key?("apr") && params.key?("years") && params.key?("pv")
   raw_apr = (params.fetch("apr").to_f / 100) / 12
   raw_years = params.fetch("years").to_i * 12
   raw_pv = params.fetch("pv").to_i
 
   numerator = raw_apr * raw_pv
   denominator = 1 - (1+raw_apr)**(-raw_years)
   @apr = ((params.fetch("apr").to_f)/12).to_fs(:percentage, { :precision => 4, :multiplier => 1})
   @years = params.fetch("years").to_i * 12
   @pv = params.fetch("pv").to_i.to_fs(:currency)
   @P = (numerator/denominator).to_fs(:currency,{:precision => 2})

  end 
  erb(:payment_result)
end
