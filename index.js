var express = require('express');
var beacon = require('./routes/beacon');
var results = require('./routes/results');
var urls = require('./routes/urls');
var app = express();

// middleware

app.use(express.logger());
app.use(express.json());
app.use(express.urlencoded());

// routing

app.post('/beacon', beacon.create);
app.get('/results', results.all);
app.del('/results', results.removeAll);
app.get('/results/latest', results.latest);
app.get('/results/:id', results.get);
app.del('/results/:id', results.remove);
app.get('/urls', urls.all);

// 404 (if we got this far then no routes were matched.)

app.use(function (req, res, next) {
  var err = new Error('Resource not found: ' + req.path);

  err.status = 404;
  next(err);
});

// error handling

app.use(function (err, req, res, next) {
  var status = err.status || 500;
  console.error(err.stack);
  res.json(status, { errors: [{ message: err.message }] });
});

module.exports = app;