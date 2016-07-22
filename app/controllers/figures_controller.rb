require 'pry'
class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.find_or_create_by(name: params[:figure][:name])
    @figure.name = params[:figure][:name]
    @figure.titles << Title.find_or_create_by(params[:title_id])
    @figure.landmarks << Landmark.find_or_create_by(params[:landmark_id])
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    elsif !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @figure.titles << Title.find_or_create_by(params[:title_id])
    @figure.landmarks << Landmark.find_or_create_by(params[:landmark_id])
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    elsif !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @figure.save
    erb :'figures/show'
  end
end

