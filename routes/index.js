var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    dal.Article.find({}, null,  {sort: '-created_at'}, function (err, articles) {
        res.render('index', { articles: articles });
    }).sort('-date');
});

module.exports = router;
