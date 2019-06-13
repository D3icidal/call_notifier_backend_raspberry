require 'sinatra'
require 'omxplayer'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    "Hello, World!"
  end

  get '/notify' do
    child_pid = Process.fork do
      exec 'open sample.mp3 &'
      sleep 10
      Process.exit
    end

    Process.detach child_pid # No zombie process
  end

  get '/status' do
    omx.status
  end

  def omx
    Omxplayer.instance(nil,output_mode='local')
    audio_out = params[:audio_out] || 'local'
    # Omxplayer.instance.open "/sample.mp3"#, :audio_output => audio_out
    # Omxplayer.instance.action("play")
    # omx.status
    # p omx.status
  end

end
