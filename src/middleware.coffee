debug       = require('debug')('FluxApp:Middleware')

class Middleware 
	constructor: (context, callback) ->
		@callback = callback.bind(context);
	

	attach: (req, res, next) ->
		@req = req;
		@res = res;
		@next = next;

	expose: (hash, name) ->
		@res.expose(hash, name)

	getPath: () ->
		@req.path
	

	render: (layout, options, callback) ->
		debug('Rendering application into layout');
		@res.render layout, options, (err, markup) =>
			callback(err);
			debug('Sending markup');
			# console.log(markup);
			@res.send(markup)
			@next(err);

	run: () ->
		@callback(@);

MakeMiddleware = (context, callback) ->
	middleware = null;
	return (req, res, next) ->
		middleware = new Middleware(context, callback) unless middleware?

		middleware.attach(req, res, next);
		middleware.run();

module.exports = MakeMiddleware
