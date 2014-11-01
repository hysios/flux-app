path 	= require('path')
AppBase = require('./app_base')
History = require('history.js')
debug 	= require('debug')('FluxApp:ClientApp');

class ClientApp extends AppBase

	constructor: (options) ->
		super(options)

		@mountNode = options.mountNode || document.body

	bindRouter: () ->

		History.Adapter.bind window,'statechange', () ->
        	state = History.getState()
        	debug('statechange', state)

 	setRoute: (path) ->
 		History.pushState({}, null, path);

 	getCurrentPath: () ->
 		location.pathname

 	run: (callback) ->
 		defaultContext = @defaultContext({})
 		@runInContext defaultContext, (context, done) =>
			@matchRoute @getCurrentPath(), (err, match) =>

				if (err)
					debug('error:' + err + ' can\'t reslove this path ' + http.getPath() + ' in router');
					return http.next(err);

				PageComponent = React.createFactory(match.fn(match.params, match.splats))

				@mountNode = document.getElementById(@mountNode) if "string" == typeof @mountNode

				React.renderComponent(PageComponent, @mountNode)

module.exports = (options) ->
	new ClientApp(options)