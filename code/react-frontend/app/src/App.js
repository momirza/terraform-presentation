import axios from 'axios';
import React, { Component } from 'react';

import logo from './iwoca-Logo.svg';
import './App.css';


class App extends Component {
  constructor(props) {
  	super(props);
    this.state = {};
  }

  componentDidMount() {
    axios.all([
      axios.get('/api/hello'),
      axios.get('/api/version')
    ])
    .then(axios.spread( (hello, version) => {
      this.setState({ hello: hello.data, version: version.data});
    }));
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
        </header>
        <p className="App-intro">
            {this.state.hello}
        </p>
        <p className="App-version">
          Flask version: {this.state.version}
        </p>
      </div>
    );
  }
}

export default App;

