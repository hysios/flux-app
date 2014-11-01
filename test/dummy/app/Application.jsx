/**
 * @jsx React.DOM
 */

var React = require('react');
var Router = require('react-router-component');
var Locations = Router.Locations;
var Location = Router.Location;
var Header = require('./components/Header.jsx');

var Application = React.createClass({

  getDefaultProps: function() {
    return {
      path: '/'
    };
  },

  render: function() {
    return (
      <div >
        <Header />
        <div className="children">
          {this.props.children}
        </div>
      </div>
    );
  }

});

module.exports = Application;
