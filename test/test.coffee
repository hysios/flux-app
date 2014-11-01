require('./lib/bootstrap');
Dispatcher = require("dispatchr")()
ProductStore = require("./dummy/app/stores/ProductStore")
ProductFetcher = require('./dummy/app/fetchers/product')
Fetcher = require('fetchr')
express = require('express')
ServerApp = require("../src/server_app")
request = require("supertest")

describe "Server Application ", () ->
	app = express()
	fluxApp = ServerApp(
		projectPath: './test/dummy'
		httpApp: app
		dispatcherAdapter: Dispatcher)

	Dispatcher.registerStore(ProductStore)
	Fetcher.registerFetcher(ProductFetcher)

	it "load", (done) ->
		request(app)
			.get("/")
			.end(done)


