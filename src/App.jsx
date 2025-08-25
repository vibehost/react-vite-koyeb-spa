import { useState, useEffect } from 'react'
import axios from 'axios'
import './App.css'

function App() {
  const [count, setCount] = useState(0)
  const [quote, setQuote] = useState('')
  const [loading, setLoading] = useState(false)

  const fetchQuote = async () => {
    setLoading(true)
    try {
      const response = await axios.get('https://api.quotable.io/random')
      setQuote(response.data.content + ' - ' + response.data.author)
    } catch (error) {
      setQuote('Failed to fetch quote')
    }
    setLoading(false)
  }

  useEffect(() => {
    fetchQuote()
  }, [])

  return (
    <div className="App">
      <h1>React Vite SPA Test</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          Count is {count}
        </button>
        <button onClick={fetchQuote} disabled={loading}>
          {loading ? 'Loading...' : 'Get New Quote'}
        </button>
      </div>
      <div className="quote-section">
        <h3>Random Quote:</h3>
        <p className="quote">{quote}</p>
      </div>
      <p className="read-the-docs">
        This is a React SPA built with Vite for VibeHost deployment testing.
      </p>
    </div>
  )
}

export default App