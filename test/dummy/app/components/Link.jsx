/**
 * @jsx React.DOM
 */

var React = require('react');

var Link = React.createClass({

  render: function() {
    // console.log('Link:', this);
    // console.log('Context:', this.context);
    return this.transferPropsTo(
      <a href={this.props.href} >{this.props.children}</a>
    );
  }

});

module.exports = Link;
