var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

getPage = require('../middleware/page/getPage');
getPages = require('../middleware/page/getPages');
updatePage = require('../middleware/page/updatePage');

router.get('/', requireAdmin(), getPages(), function(req, res) {
    res.render('pages/adminList', { pages: req.pages });
});

router.get('/:name', getPage(), function(req, res) {
    res.render('pages/view', { page: req.page });
});

router.get('/:name/edit', requireAdmin(), getPage(), function(req, res) {
    res.render('pages/edit', { page: req.page });
});

router.post('/:id', requireAdmin(), updatePage(), function(req, res) {
    res.redirect('/oldal');
});


module.exports = router;
