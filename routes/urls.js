var service = require('yslow-data-service');

module.exports = {

  /**
   * GET /urls
   */

  all: function (req, res, next) {
    service.urls.all(function (err, urls) {
      if (err) return next(err);

      res.json({urls: urls});
    });
  }

}