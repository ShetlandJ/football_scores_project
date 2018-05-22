var express = require('express');
var app = express();
var mysql = require('mysql');

app.get('/', function(req, res) {

  const { Pool, Client } = require('pg')
  const connectionString = 'postgresql://localhost:5432/football_scores'

  const pool = new Pool({
    connectionString: connectionString,
  })

  // pool.query('SELECT NOW()', (err, res) => {
  //   console.log(err, res)
  //   pool.end()
  // })

  const client = new Client({
    connectionString: connectionString,
  })

  client.connect()

  client.query('SELECT * FROM fixtures', (err, res) => {
    if (err) {
      console.log(err.stack)
    } else {
      console.log(res.rows)
    }
  })

});

app.listen(5000, function(){
  console.log("Listening on port 5000");
});



module.exports = app;
