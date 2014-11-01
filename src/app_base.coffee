path 		= require("path")
Dispatchr 	= require("dispatchr")()
Context 	= require("./context")
Fetcher 	= require("fetchr")
Router 		= require("./router")
React 		= require("react")
debug		= require("debug")("FluxApp:Base")
ReactCurrentOwner = require("react/lib/ReactCurrentOwner")

class App

	###*
	 * [constructor description]
	 * @param  {[type]} @options [description]
	 * @return {[type]}          [description]
	###	
	constructor: (options) ->
		@projectPath = path.resolve(options.projectPath || process.cwd())
		@appPath = path.join(this.projectPath, "app")
		@appJsxName = options.appJsxName || "Application.jsx"
		# @applicationFile = path.join(this.appPath, this.appJsxName);
		@values = {}
		debug("load routes files:", @appPath + "/router.js")
		@router = new Router(@appPath + "/router.js") unless @router?
		@pagePrefix = options.pagePrefix || "Open"
		@pageSuffix = options.pageSuffix || "Page"
		@stores = options.stores || []
		@dispatcherAdapter = options.dispatcherAdapter || Dispatchr
		@dispatcher = options.dispatcher || new @dispatcherAdapter({})

		# for store of @stores
		# 	@registerStore(store);


	set: (name, value) ->
		@values[name] = value;
		null

	get: (name) ->
		@values[name]
  

	createContext: (context = {}) ->
		context["app"] = @
		context["dispatcher"] = @dispatcher
		new Context(context)
  
	defaultContext: (context) ->
		@_defaultContext = @createContext(context) unless @_defaultContext?

	runInNewContext: (_context, callback) ->
		context = @createContext(_context)
		@runInContext(context, callback)
  
	runInContext: (context, callback) ->
		ReactCurrentOwner.current = context.actionContext;
		callback context, ->
			if context.destory && "function" == typeof context.destory
				context.destory()

			ReactCurrentOwner.current = null;

	matchRoute: (path, callback) ->
		matchObject = @router.match(path);
		debug("match route::", path, "matchObject", matchObject);
		callback((if matchObject then null else 404), matchObject)

module.exports = App
