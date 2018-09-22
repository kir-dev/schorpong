var express = require('express');
var router = express.Router();

var requireAdmin = require('../middleware/auth/requireAdmin');
var requireLogin = require('../middleware/auth/requireLogin');

var getAllOrders = require('../middleware/cart/getAllOrders');
var getOrders = require('../middleware/cart/getOrders');
var getCartItems = require('../middleware/cart/getCartItems');
var confirmCart = require('../middleware/cart/confirmCart');
var addCartItem = require('../middleware/cart/addCartItem');
var updateCartItem = require('../middleware/cart/updateCartItem');
var deleteCartItem = require('../middleware/cart/deleteCartItem');


router.get('/', requireAdmin(), getAllOrders(), function(req, res) {
    res.render('cart/listAllOrders', { carts: req.carts });
});

router.get('/kosar', requireLogin(), getCartItems(), function(req, res) {
    res.render('cart/list', { cart: req.cart });
});

router.get('/kolcsonzeseim', requireLogin(), getOrders(), function(req, res) {
    res.render('cart/listOrders', { carts: req.carts });
});

router.post('/confirm', requireLogin(), confirmCart(), function(req, res) {
    res.redirect('/kolcsonzes/kolcsonzeseim');
});

router.post('/:id', requireLogin(), addCartItem(), function(req, res) {
    req.flash('success', 'Sikeresen a kosaradba helyezted.');
    res.redirect('/eszkozok/lista');
});

router.post('/:id/edit', requireLogin(), updateCartItem(), function(req, res) {
    res.redirect('/kolcsonzes/kosar');
});

router.get('/:id/delete', requireLogin(), deleteCartItem(), function(req, res) {
    res.redirect('/kolcsonzes/kosar');
});

module.exports = router;
