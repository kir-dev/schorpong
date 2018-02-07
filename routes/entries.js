var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getEntry = require('../middleware/entry/getEntry');
var getEntries = require('../middleware/entry/getEntries');
var createEntry = require('../middleware/entry/createEntry');
var updateEntry = require('../middleware/entry/updateEntry');
var deleteEntry = require('../middleware/entry/deleteEntry');

router.get('/lista', getEntries(), function(req, res) {
    res.render('entries/list', { entries: req.entries });
});

router.get('/', getEntries(), function(req, res) {
    res.render('entries/adminList', { entries: req.entries });
});

router.get('/new', requireAdmin(), function(req, res) {
    res.render('entries/new');
});

router.get('/:id', getEntry(), function(req, res) {
    res.render('entries/view', { entry: req.entry });
});


router.get('/:id/edit', getEntry(), function(req, res) {
    res.render('entries/edit', { entry: req.entry });
});

router.post('/', requireAdmin(), createEntry(), function(req, res) {
    res.redirect('/');
});

router.post('/:id', requireAdmin(), updateEntry(), function(req, res) {
    res.redirect('/nevezesek')
});

router.get('/:id/delete', requireAdmin(), deleteEntry(), function(req, res) {
    res.redirect('/nevezesek');
});

module.exports = router;
