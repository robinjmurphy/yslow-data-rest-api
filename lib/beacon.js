var service = require('yslow-data-service');

module.exports = {

  create: function (req, res, next) {
    var data = req.body;

    service.results.create(data, function (err, report) {
      if (err) next(err);

      res.header('Location', '/results/' + report.id);
      res.send(201);
    });
  }

}