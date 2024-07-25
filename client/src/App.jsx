import './App.css'
import { BrowserRouter as Router, Routes, Route} from "react-router-dom"
import Tokenize from './pages/Tokenize'
import HomePage from './pages/HomePage'
import Layout from './layout'
import Withdraw from './pages/Withdraw'

function App() {
  

  return (
    <Router>
      <Layout>
          <Routes>
            <Route path='/' element={<HomePage/>} />
            <Route path='/tokenize' element={<Tokenize/>} />
            <Route path='/get-btc' element={<Withdraw/>} />
          </Routes>
      </Layout>
      
    </Router>
  )
}

export default App
