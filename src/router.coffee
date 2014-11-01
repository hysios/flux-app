Routes = require('routes')
debug = require('debug')('FluxApp:Routes')

class Router 
	constructor: (file) ->
		@router = Routes()

		debug('load routes file: ' + file);
		config = @loadRouterConfig(file);
		debug('start building routes')
		@buildRouter(config);
		debug('end building routes')
  

	loadRouterConfig: (configFile) ->
		@config = require(configFile)
		return @config

	buildRouter: (config) ->

		debug('load routes', config);
		for key of config 
			if config.hasOwnProperty(key)
				route = config[key];
				debug('register route with' + key);
				@router.addRoute(key, route)

	match: (path) ->
		return @router.match(path);

module.exports = Router;
