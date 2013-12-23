var service = require('yslow-data-service');

module.exports = {

  all: function (req, res, next) {
    service.urls.all(function (err, urls) {
      if (err) next(err);

      res.json(urls);
    });
  }

}