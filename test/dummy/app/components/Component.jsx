/**
 * @jsx React.DOM
 */

var React = require('react');
var ComponentMixin = require(process.cwd() + '/lib/mixins/component');

var Component = React.createClass({
  mixins: [ ComponentMixin ],

  render: function() {
    // console.log(this.getContext());

    return (
      <div >{this.getContext().name} {this.getContext().id}</div>
    );
  }

});

module.exports = Component;
