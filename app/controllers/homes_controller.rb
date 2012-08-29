require 'rubygems'
require 'nokogiri'
require 'zip/zip'  
require 'open-uri'

class HomesController < ApplicationController
	def index
    @homes = Home.all
		client = LinkedIn::Client.new("gjdmnasx5r07", "rBGljeWQOcZfBesW")
    request_token = client.request_token(:oauth_callback => "http://localhost:3000/homes/show")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
	
    redirect_to client.request_token.authorize_url
	end

 def show

  #puts "*******************"
  #@home = Home.find(params[:id])
  #zip = Zip::ZipFile.open('public/data/mark.docx')
  #doc = zip.find_entry("word/document.xml")  
  #xml = Nokogiri::XML.parse(doc.get_input_stream) 
  #puts xml
  #@testing= xml.text
  #puts "*******************"
  #puts "*******************"

    client = LinkedIn::Client.new("gjdmnasx5r07", "rBGljeWQOcZfBesW")
    if session[:atoken].nil?
    pin = params[:oauth_verifier]
    atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
    session[:atoken] = atoken
    session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile = client.profile(:fields => %w(positions))
    @connections = client.connections
puts "------------------------------"
    client.profile(:fields => %w(positions)).each_pair do |key, value|
  p key
  p value
end
puts "------------------------------"
puts "------------------------------"
    puts client.profile
puts "------------------------------"
puts "------------------------------"
  @profile.positions.all[0].company.each do |key, value|
  	  p key
      p value
  end
puts "------------------------------"
#views
#<!--<%= @profile.positions.all %></br></br>-->
#<!--<%= @companies %></br></br>-->
#<!--<%= @connections %></br></br>-->
  end

  def new
    @home = Home.new
    client = LinkedIn::Client.new("gjdmnasx5r07", "rBGljeWQOcZfBesW")
    if session[:atoken].nil?
    pin = params[:oauth_verifier]
    atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
    session[:atoken] = atoken
    session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile = client.profile(:fields => %w(positions))
    @connections = client.connections
     client.profile.post("blah")
    client.profile(:fields => %w(positions)).each_pair do |key, value|
end
  end

  def create
    @home = Home.new(params[:home])
    @home.save
  end


end
