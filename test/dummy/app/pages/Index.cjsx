## @cjsx React.DOM

React = require('react')
debug = require('debug')('Components:Index')

IndexPage = React.createClass {

  getInitialState: () ->
    debug(this._owner);
    return {
      appId: this._owner.id
    }

  render: () ->
    return (
      <div > AppId: {this.state.appId}</div>
    )
}

module.exports = IndexPage;
