import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css'
import { Flowbite } from 'flowbite-react'
import { Web3Provider } from './utils/providers/Web3Provider'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <Flowbite>
      <Web3Provider>
          <App />
      </Web3Provider>
    </Flowbite>
  </React.StrictMode>,
)
