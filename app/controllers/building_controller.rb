class BuildingController < ApplicationController
    get "/buildings" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @buildings = Building.all
            erb :"buildings/index"
        else
            redirect "/login"
        end
    end

    get "/buildings/new" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @characters = @user.characters
            @locations = Location.all
            erb :"/buildings/new"
        else
            redirect "/login"
        end 
    end
    get "/buildings/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = Building.find_by_id(params[:id])
            erb :"buildings/show"
        else
            redirect "/login"
        end
    end

    get "/buildings/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = Building.find_by_id(params[:id])
            erb :"buildings/edit"
        else
            redirect "/login"
        end
    end

    post "/buildings" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = []
            if !!params[:building][:name]
                binding.pry
                @building = Building.create(params[:building])
            end
            redirect "/buildings/#{@building.id}"
        else
            redirect "/login"
        end
    end

    patch "/buildings/:id" do
        @user = User.current_user(session)
        @building = Building.find_by_id(params[:id])
        @building.update(params[:building])
        redirect "/buildings/#{@building.id}"
    end

    delete "/buildings/:id" do
        Building.destroy(params[:id])
        redirect "/buildings"
    end
end