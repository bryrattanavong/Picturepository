import React from 'react';
import logo from './logo.svg';
import Searchbar from './Components/Searcbar'
import './styles/App.css';

const App: React.FC = () => {
  return (
    <div className="Container">
      <div className="Header">The Shoppies</div>
      <div className="Searchcontainer">
        <div>Movie Title</div>
        <Searchbar/>
      </div>
   </div>
  );
}

export default App;
