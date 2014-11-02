debug = require('debug')('flux-app')

class Server
	constructor: (@options) ->
		@port = @options.port
		@environment = @options.environment
		if 'boolean' == typeof @options.debug
			@debugEnable = @options.debug
		else 
			@debugEnable = @environment == 'development' ? true

	run: () ->
		if @environment == 'development'
			debug('start server in development environment')

	debug: (args...) ->
		debug.apply(null, args) if @debugEnable
			

module.exports = server = (options) ->
	server = new Server(options)

	server.run()