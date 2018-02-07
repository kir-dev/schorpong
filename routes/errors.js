var express = require('express');
var router = express.Router();

router.get('/require-login', function(req, res) {
    res.render('errors/403');
});

module.exports = router;
