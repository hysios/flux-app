AppBase = require('./app_base')
path = require('path')
debug = require('debug')('FluxApp:ServerApp')
express = require('express')
expressState = require('express-state')
React = require('react')
Router = require('./router')
String = require('./utils/String')
Middleware = require('./middleware')
expressHtml = require('lodash-express')
serverRender = require('./utils/serverRender');

class ServerApp extends AppBase

	constructor: (options = {}) ->
		super(options)

		@httpApp = options.httpApp || null;
		@setupHttpApp(@httpApp) if @httpApp?

	setupHttpApp: (httpApp) ->


		expressState.extend(httpApp)
		expressHtml(httpApp, 'html')

		httpApp.set('view engine', 'html');
		httpApp.set('views', @appPath + '/pages')
		httpApp.use(Middleware(@, @middleware))
  
	middleware: (http) ->
		@runInNewContext {http: http}, (context, done) =>
			@matchRoute http.getPath(), (err, match) =>
				if (err)
					debug('error:' + err + ' can\'t reslove this path ' + http.getPath() + ' in router');
					return http.next(err);

				PageComponent = React.createFactory(match.fn(http, match.params, match.splats))

				page = PageComponent({}, null)
				Action = @getPageAction(http.getPath());

				if (Action)
					context.actionContext.executeAction Action, {}, (err) =>
						return done(err) if (err) 
						serverRender(page, http, context, done)

				else
					serverRender(page, http, context, done)

	getPageAction: (name) ->
		name = "index" if name == "/"
		ActionName = @pagePrefix + String.capitalize(name) + @pageSuffix
		actionPath = path.join(@appPath, "/actions/", ActionName)
		Action = null;

		try 
			Action = require(actionPath)
		catch e
			Action = null

		return Action

module.exports = (options) ->
	new ServerApp(options)