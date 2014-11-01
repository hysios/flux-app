Fetcher = require('fetchr');
debug = require('debug')('FluxApp:Context');

class Context

	constructor: (options) ->
		@dispatcher = options.dispatcher;
		@app = options.app;
		@id = Math.random() * 10000;
		@http = options.http;
		@fetcher = options.fetcher || new Fetcher({req: @http.req});
		@actionContext = @getActionContext();
		@componentContext= @getComponentContext()
	
	getComponentContext: () ->
		return {
			executeAction: (actionController, payload) =>
				actionController actionCOntext, payload, () ->
					debug(err) if (err)
			,
			getStore: @dispatcher.getStore.bind(@dispatcher)
		}

	getActionContext: () ->
		return {
			dispatch: @dispatcher.dispatch.bind(@dispatcher),
			executeAction: (actionController, payload, done) =>
				actionController(@actionContext, payload, done)
			,
			fetcher: @fetcher,
			getStore: @dispatcher.getStore.bind(@dispatcher)
		}

	executeAction: (action, payload, done) ->
		action(this, payload, done)

	dehydrate: () ->
		return {
			dispatcher: @dispatcher.dehydrate()
		}
	
	rehydrate: (obj) ->
		@dispatcher.rehydrate(obj.dispatcher || {})

module.exports = Context;
