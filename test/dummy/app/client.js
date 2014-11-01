/*global App, document, window */
'use strict';
ClientApp = require('../../../lib/client_app');
var React = require('react'),
    debug = require('debug'),
    fetcher = new Fetcher({
        xhrPath: Application.config.xhrPath
    }),

	dehydratedState = App && App.Context; // Sent from the server

window.React = React; // For chrome dev tool support
debug.enable('*');

bootstrapDebug('rehydrating app');
var application = ClientApp({
    fetcher: fetcher,
    initialState: dehydratedState,
    mountNodeId: 'app'
})

application.run();

// window.context = application.context;

// var app = application.getComponent(),
//     mountNode = document.getElementById('app');

// bootstrapDebug('React Rendering');
// React.renderComponent(app, mountNode, function () {
//     bootstrapDebug('React Rendered');
// });
