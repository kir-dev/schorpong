var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');

var getArticle = require('../middleware/article/getArticle');
var getArticles = require('../middleware/article/getArticles');
var createArticle = require('../middleware/article/createArticle');
var updateArticle = require('../middleware/article/updateArticle');
var deleteArticle = require('../middleware/article/deleteArticle');

router.get('/', getArticles(), function(req, res) {
	res.render('articles/adminList', { articles: req.articles });
});

router.get('/new', requireAdmin(), function(req, res) {
	res.render('articles/new');
});

router.get('/:id', getArticle(), function(req, res) {
	res.render('articles/view', { article: req.article });
});


router.get('/:id/edit', getArticle(), function(req, res) {
    res.render('articles/edit', { article: req.article });
});

router.post('/', requireAdmin(), createArticle(), function(req, res) {
	res.redirect('/');
});

router.post('/:id', requireAdmin(), updateArticle(), function(req, res) {
	res.redirect('/hirek')
});

router.get('/:id/delete', requireAdmin(), deleteArticle(), function(req, res) {
	res.redirect('/hirek');
});


module.exports = router;
