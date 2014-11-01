/**
 * @jsx React.DOM
 */

var React = require('react');

var AsyncComponent = React.createClass({
  getInitialState: function() {
    setTimeout(this.increaseValue, 1000);

    return {
      value: 0
    };
  },

  increaseValue: function() {
    this.setState({
      value: this.state.value + 1
    });
  },

  render: function() {
    return (
      <div >Value: {this.state.value}</div>
    );
  }

});

module.exports = AsyncComponent;
