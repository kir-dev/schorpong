var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getUser = require('../middleware/user/getUser');
var getUsers = require('../middleware/user/getUsers');
var updateUser = require('../middleware/user/updateUser');
var deleteUser = require('../middleware/user/deleteUser');

router.get('/list', getUsers(), function(req, res) {
    res.render('users/list', { users: req.users });
});

router.get('/', requireAdmin(), getUsers(), function(req, res) {
    res.render('users/adminList', { users: req.users });
});


router.get('/:id', getUser(), function(req, res) {
    res.render('users/view', { user: req.user });
});


router.get('/:id/edit', getUser(), function(req, res) {
    res.render('users/edit', { user: req.user });
});

router.post('/:id', requireAdmin(), updateUser(), function(req, res) {
    res.redirect('/felhasznalok')
});

router.get('/:id/delete', requireAdmin(), deleteUser(), function(req, res) {
    res.redirect('/felhasznalok');
});

module.exports = router;
