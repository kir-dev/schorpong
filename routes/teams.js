var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getTeam = require('../middleware/team/getTeam');
var getTeams = require('../middleware/team/getTeams');
var createTeam = require('../middleware/team/createTeam');
var updateTeam = require('../middleware/team/updateTeam');
var deleteTeam = require('../middleware/team/deleteTeam');

var joinTeam = require('../middleware/team/joinTeam');
var canCreateTeam = require('../middleware/team/canCreateTeam');
var hasTeam = require('../middleware/team/hasTeam');

router.get('/lista', getTeams(), function(req, res) {
    res.render('teams/list', { teams: req.teams });
});
router.get('/csapatom', hasTeam(), function(req, res) {
    res.end('asd');
});

router.get('/', getTeams(), function(req, res) {
    res.render('teams/adminList', { teams: req.teams });
});

router.get('/new', canCreateTeam(), getTeams(), function(req, res) {
    res.render('teams/new', { teams: req.teams });
});

router.get('/:id', getTeam(), function(req, res) {
    res.render('teams/view', { team: req.team });
});


router.get('/:id/edit', getTeam(), function(req, res) {
    res.render('teams/edit', { team: req.team });
});

router.post('/', canCreateTeam(), createTeam(), function(req, res) {
    res.redirect('/');
});

router.post('/:id/join', joinTeam(), function(req, res) {
    res.redirect('/csapatok/csapatom');
});

router.post('/:id', requireAdmin(), updateTeam(), function(req, res) {
    res.redirect('/csapatok')
});

router.get('/:id/delete', requireAdmin(), deleteTeam(), function(req, res) {
    res.redirect('/csapatok');
});

module.exports = router;
