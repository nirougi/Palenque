# ============================= #
# Collection                    #
# ============================= #

uniSteppers = []

# ============================= #
# Routes                        #
# ============================= #

# Setup

get '/:key/unistepper/new/:pins/:speed' do
    pins = params[:pins].split(",").map { |s| s.to_i }
    uniSteppers.push UnipolarStepper.new pins, params[:speed].to_f

    response = [ :status => 'true', :message => 'Stepper motor created', :id => uniSteppers.length-1 ]
    jsonp response
end

get '/:key/unistepper/list' do
    jsonp uniSteppers
end

### Needs improve on ids
get '/:key/unistepper/delete/:id' do
    uniSteppers[params[:id].to_i] = nil

    response = [ :status => 'true', :message => 'Stepper motor deleted', :id => params[:id].to_i ]
    jsonp response
end

# Rolling

['/:key/unistepper/:id/rotate/:steps', '/:key/unistepper/:id/rotate/:steps/:speed']
.each do |path|
    get path do
        if params[:speed] != nil
            uniSteppers[params[:id].to_i].rotate params[:steps].to_i, params[:speed].to_f
        else
            uniSteppers[params[:id].to_i].rotate params[:steps].to_i
        end

        response = [ :status => 'true', :message => 'Stepper motor stopped rotate' ]
        jsonp response
    end
end

['/:key/unistepper/:id/spin/:direction', '/:key/unistepper/:id/spin/:direction/:speed']
.each do |path|
    get path do
        if params[:speed] != nil
            uniSteppers[params[:id].to_i].spin params[:direction].to_i, params[:speed].to_f
        else
            uniSteppers[params[:id].to_i].spin params[:direction].to_i
        end

        response = [ :status => 'true', :message => 'Stepper motor started spin' ]
        jsonp response
    end
end

get '/:key/unistepper/:id/stop' do
    uniSteppers[params[:id].to_i].stop

    response = [ :status => 'true', :message => 'Stepper motor stoped' ]
    jsonp response
end

# Status

get '/:key/unistepper/:id/moving' do

    if uniSteppers[params[:id].to_i].is_rotating?
        response = [ :status => 'true', :type => "rotating", :message => 'Stepper motor is rotating' ]
    elsif uniSteppers[params[:id].to_i].is_spinning?
        response = [ :status => 'true', :type => "spinning", :message => 'Stepper motor is spinning' ]
    else
        response = [ :status => 'false', :message => 'Stepper motor is stoped' ]
    end
    jsonp response
end