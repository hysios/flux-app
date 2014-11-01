/**
 * @jsx React.DOM
 */

var React = require('react');
var Link = require('./Link.jsx');

var Header = React.createClass({

  render: function() {
    return (
      <div >
        <Link href="#">Hello World</Link>
      </div>
    );
  }

});

module.exports = Header;
