// Generated by CoffeeScript 1.8.0
(function() {
  var React, debug, retrievePropsFromPage, serverRender;

  React = require('react');

  debug = require('debug')('serverRender');

  retrievePropsFromPage = require('./retrievePropsFromPage');

  module.exports = serverRender = function(page, http, context, callback) {
    var html, htmlOptions, props;
    if (page != null) {
      props = retrievePropsFromPage(page);
      debug('retrive page props', props);
      html = React.renderToString(page);
      console.log(context);
      debug('expose context', context.dehydrate());
      http.expose(context.dehydrate(), 'Context');
      htmlOptions = {
        body: html,
        title: props.title,
        description: props.description
      };
      return http.render('_template', htmlOptions, callback);
    } else {
      return callback({
        code: 503,
        err: 'page JSX file not found'
      });
    }
  };

}).call(this);