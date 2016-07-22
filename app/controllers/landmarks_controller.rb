require 'pry'

class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    @landmark.year_completed = params[:landmark][:year_completed]
    @landmark.save
    redirect to "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  post '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    if !params[:landmark][:name].empty?
     @landmark.name = params[:landmark][:name]
    end
    if !params[:landmark][:year_completed].empty?
     @landmark.year_completed = params[:landmark][:year_completed]
    end
    @landmark.save
    erb :'landmarks/show'
  end
end
