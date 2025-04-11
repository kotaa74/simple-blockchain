#!/data/data/com.termux/files/usr/bin/bash

  # Node.js service for CYVX
  npm install express axios

  # Start REST API server
  echo "Starting CYVX REST API server..."
  node -e "const express = require(express); const app = express(); const port = 3000; 
  app.get(/, (req, res) => { res.send(CYVX Blockchain Node API Running); }); 
  app.listen(port, () => { console.log(Server running on http://localhost: + port); });"
  
