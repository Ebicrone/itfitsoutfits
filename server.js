const express = require('express');
const sql = require('mssql');
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.static('frontend'));

// CONFIGURE YOUR DATABASE AND SERVER HERE !!!!
const config = {
  user: 'sa', //Input username used in SQL Management Studio.
  password: 'systemadmin', //Input password for said username in SQL Management Studio.
  server: 'JOLO', //Input server name used during login in SQL Management Studio.
  server: 'KRUGS', //Input server name used during login in SQL Management Studio.
  database: 'ITFITS', 
  options: {
    encrypt: true,
    trustServerCertificate: true
  }
};

const pool = new sql.ConnectionPool(config);
const poolConnect = pool.connect();

// Register route
app.post('/api/register', async (req, res) => {
  const { username, email, password, firstName, lastName, height, weight } = req.body;

  if (!username || !email || !password) {
    return res.status(400).send('Missing required fields.');
  }

  try {
    await poolConnect;
    const request = pool.request();

    request.input('username', sql.VarChar, username);
    request.input('email', sql.VarChar, email);
    request.input('password', sql.VarChar, password);
    request.input('firstName', sql.VarChar, firstName || '');
    request.input('lastName', sql.VarChar, lastName || '');
    request.input('weight', sql.Float, weight || 0);
    request.input('height', sql.Float, height || 0);
    request.input('userRole', sql.VarChar, 'Customer');
    request.input('userStatus', sql.VarChar, 'active');

    await request.query(`
      INSERT INTO USER_ACCOUNT
      (username, email, password, firstName, lastName, weight, height, userRole, lastLogin, userStatus)
      VALUES
      (@username, @email, @password, @firstName, @lastName, @weight, @height, @userRole, GETDATE(), @userStatus)
    `);

    res.send('Registration successful.');
  } catch (err) {
    console.error('SQL error', err);
    res.status(500).send('Database error');
  }
});

// Login route
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).send({ success: false, message: 'Missing username or password.' });
  }

  try {
    await poolConnect;
    const request = pool.request();

    request.input('username', sql.VarChar, username);
    request.input('password', sql.VarChar, password);

    const result = await request.query(`
      SELECT * FROM USER_ACCOUNT
      WHERE username = @username AND password = @password
    `);

    if (result.recordset.length > 0) {
      const user = result.recordset[0];
      res.send({
        success: true,
        message: 'Login successful.',
        user: {
          username: user.username,
          userRole: user.userRole
        }
      });
    } else {
      res.status(401).send({ success: false, message: 'Invalid credentials.' });
    }
  } catch (err) {
    console.error('SQL error', err);
    res.status(500).send({ success: false, message: 'Database error.' });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
