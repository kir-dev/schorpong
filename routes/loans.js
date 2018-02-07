var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getLoan = require('../middleware/loan/getLoan');
var getLoans = require('../middleware/loan/getLoans');
var createLoan = require('../middleware/loan/createLoan');
var updateLoan = require('../middleware/loan/updateLoan');
var deleteLoan = require('../middleware/loan/deleteLoan');

router.get('/lista', getLoans(), function(req, res) {
    res.render('loans/list', { loans: req.loans });
});

router.get('/', getLoans(), function(req, res) {
    res.render('loans/adminList', { loans: req.loans });
});

router.get('/new', requireAdmin(), function(req, res) {
    res.render('loans/new');
});

router.get('/:id', getLoan(), function(req, res) {
    res.render('loans/view', { loan: req.loan });
});


router.get('/:id/edit', getLoan(), function(req, res) {
    res.render('loans/edit', { loan: req.loan });
});

router.post('/', requireAdmin(), createLoan(), function(req, res) {
    res.redirect('/');
});

router.post('/:id', requireAdmin(), updateLoan(), function(req, res) {
    res.redirect('/eszkozok')
});

router.get('/:id/delete', requireAdmin(), deleteLoan(), function(req, res) {
    res.redirect('/eszkozok');
});

module.exports = router;
