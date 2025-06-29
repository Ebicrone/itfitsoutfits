const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

app.use(express.static('frontend'));


app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'frontend', 'login.html'));
});
app.get('/register', (req, res) => {
  res.sendFile(path.join(__dirname, 'frontend', 'register.html'));
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
