var service = require('yslow-data-service');

module.exports = {

  all: function (req, res, next) {
    var options = {};
    var limit = req.query.limit;
    var url = req.query.url;

    if (limit) options.limit = limit;
    if (url) options.url = url;

    service.results.all(options, function (err, results) {
      if (err) next(err);

      res.json(results);
    });
  },

  latest: function (req, res, next) {
    var options = {};
    var url = req.query.url;

    if (url) options.url = url;

    service.results.latest(options, function (err, result) {
      if (err) next(err);

      res.json(result);
    });
  },

  get: function (req, res, next) {
    var id = req.params.id;

    service.results.findById(id, function (err, result) {
      if (result === null) {
        err = new Error('Result with ID ' + id + ' could not be found');
        err.status = 404;
      }

      if (err) next(err);

      res.json(result);
    });
  },

  remove: function (req, res, next) {
    var id = req.params.id;

    service.results.removeById(id, function (err) {
      if (err) next(err);

      res.send(204);
    });
  },

  removeAll: function (req, res, next) {
    service.results.removeAll(function (err) {
      if (err) next(err);

      res.send(204);
    });
  }

}