var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getTool = require('../middleware/tool/getTool');
var getTools = require('../middleware/tool/getTools');
var createTool = require('../middleware/tool/createTool');
var updateTool = require('../middleware/tool/updateTool');
var deleteTool = require('../middleware/tool/deleteTool');

router.get('/lista', getTools(), function(req, res) {
    res.render('tools/list', { tools: req.tools });
});

router.get('/', requireAdmin(), getTools(), function(req, res) {
    res.render('tools/adminList', { tools: req.tools });
});

router.get('/new', requireAdmin(), function(req, res) {
    res.render('tools/new');
});

router.get('/:id', getTool(), function(req, res) {
    res.render('tools/view', { tool: req.tool });
});


router.get('/:id/edit', requireAdmin(), getTool(), function(req, res) {
    res.render('tools/edit', { tool: req.tool });
});

router.post('/', requireAdmin(), createTool(), function(req, res) {
    res.redirect('/');
});

router.post('/:id', requireAdmin(), updateTool(), function(req, res) {
    res.redirect('/eszkozok')
});

router.get('/:id/delete', requireAdmin(), deleteTool(), function(req, res) {
    res.redirect('/eszkozok');
});

module.exports = router;
