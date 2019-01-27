class Api::ApiController < ApplicationController 
    def index
        return render json: { "message": "200" }
    end
end