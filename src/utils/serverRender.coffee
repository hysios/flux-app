React = require('react');
debug = require('debug')('serverRender')

retrievePropsFromPage = require './retrievePropsFromPage'

module.exports = serverRender = (page, http, context, callback) ->
	if page?
		props = retrievePropsFromPage(page)
		debug('retrive page props', props)
		html = React.renderToString(page)
		# console.log(context);
		debug('expose context', context.dehydrate())
		http.expose(context.dehydrate(), 'Context')

		htmlOptions = {
			body: html,
			title: props.title,
			description: props.description
		}

		http.render('_template', htmlOptions, callback)
	else
		callback({
			code: 503,
			err: 'page JSX file not found'
		});