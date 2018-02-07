var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getTeam = require('../middleware/team/getTeam');
var getTeams = require('../middleware/team/getTeams');
var createTeam = require('../middleware/team/createTeam');
var updateTeam = require('../middleware/team/updateTeam');
var deleteTeam = require('../middleware/team/deleteTeam');

router.get('/lista', getTeams(), function(req, res) {
    res.render('teams/list', { teams: req.teams });
});

router.get('/', getTeams(), function(req, res) {
    res.render('teams/adminList', { teams: req.teams });
});

router.get('/new', requireAdmin(), function(req, res) {
    res.render('teams/new');
});

router.get('/:id', getTeam(), function(req, res) {
    res.render('teams/view', { team: req.team });
});


router.get('/:id/edit', getTeam(), function(req, res) {
    res.render('teams/edit', { team: req.team });
});

router.post('/', requireAdmin(), createTeam(), function(req, res) {
    res.redirect('/');
});

router.post('/:id', requireAdmin(), updateTeam(), function(req, res) {
    res.redirect('/csapatok')
});

router.get('/:id/delete', requireAdmin(), deleteTeam(), function(req, res) {
    res.redirect('/csapatok');
});

module.exports = router;
