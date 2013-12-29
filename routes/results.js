var service = require('yslow-data-service');

module.exports = {

  /**
   * GET /results
   */

  all: function (req, res, next) {
    var options = {};
    var limit = req.query.limit;
    var url = req.query.url;

    if (limit) options.limit = limit;
    if (url) options.url = url;

    service.results.all(options, function (err, results) {
      if (err) return next(err);

      res.json({results: results});
    });
  },

  /**
   * GET /results/latest
   */

  latest: function (req, res, next) {
    var options = {};
    var url = req.query.url;

    if (url) options.url = url;

    service.results.latest(options, function (err, result) {
      var results = [];

      if (err) return next(err);

      if (result) {
        results.push(result);
      }

      res.json({results: results});
    });
  },

  /**
   * GET /results/:id
   */

  get: function (req, res, next) {
    var id = req.params.id;

    service.results.findById(id, function (err, result) {
      if (result === null) {
        err = new Error('Result with ID ' + id + ' could not be found');
        err.status = 404;
      }

      if (err) return next(err);

      res.json({results: [result]});
    });
  },

  /**
   * DELETE /results/:id
   */

  remove: function (req, res, next) {
    var id = req.params.id;

    service.results.removeById(id, function (err) {
      if (err) return next(err);

      res.send(204);
    });
  },

  /**
   * DELETE /results
   */

  removeAll: function (req, res, next) {
    service.results.removeAll(function (err) {
      if (err) return next(err);

      res.send(204);
    });
  }

}