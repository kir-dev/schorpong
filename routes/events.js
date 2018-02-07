var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getEvent = require('../middleware/event/getEvent');
var getEvents = require('../middleware/event/getEvents');
var createEvent = require('../middleware/event/createEvent');
var updateEvent = require('../middleware/event/updateEvent');
var deleteEvent = require('../middleware/event/deleteEvent');

router.get('/', getEvents(), function(req, res) {
    res.render('events/adminList', { events: req.events });
});

router.get('/lista', getEvents(), function(req, res) {
    res.render('events/list', { events: req.events });
});

router.get('/new', requireAdmin(), function(req, res) {
    res.render('events/new');
});

router.get('/:id', getEvent(), function(req, res) {
    res.render('events/view', { event: req.event });
});


router.get('/:id/edit', getEvent(), function(req, res) {
    res.render('events/edit', { event: req.event });
});

router.post('/', requireAdmin(), createEvent(), function(req, res) {
    res.redirect('/');
});

router.post('/:id', requireAdmin(), updateEvent(), function(req, res) {
    res.redirect('/hirek')
});

router.get('/:id/delete', requireAdmin(), deleteEvent(), function(req, res) {
    res.redirect('/hirek');
});

module.exports = router;
