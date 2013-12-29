var service = require('yslow-data-service');

module.exports = {

  /**
   * POST /beacon
   */

  create: function (req, res, next) {
    var data = req.body;

    service.results.create(data, function (err, result) {
      if (err) return next(err);

      res.header('Location', '/results/' + result.id);
      res.json(201, {results: [result]});
    });
  }

}