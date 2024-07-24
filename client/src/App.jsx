import { useState } from 'react'
import './App.css'
import { BrowserRouter as Router, Routes, Route} from "react-router-dom"
import Tokenize from './pages/Tokenize'
import ChooseChainComponent from './components/ChoseChainComponent'
import MintToken from './components/MintTokenComponent'
import Layout from './layout'

function App() {
  

  return (
    <Router>
      <Layout>
          <Routes>
            <Route path='/' element={<Tokenize/>} />
            <Route path='/choose-chain' element={<ChooseChainComponent/>} />
            <Route path='/mint-token' element={<MintToken/>}/>
          </Routes>
      </Layout>
      
    </Router>
  )
}

export default App
