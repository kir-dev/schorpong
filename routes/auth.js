var express = require('express');
var router = express.Router();
var passport = require('passport');

router.use('/login',
    passport.authenticate('oauth2'));

router.use('/logout',
    function (req, res) {
        req.logout();
        res.redirect('/');
    });

router.use('/example/callback',
    function (req, res, next) {
        if (req.isAuthenticated()) {
            res.redirect('/');
        } else {
            return next();
        }
    },
    passport.authenticate('oauth2', {failureRedirect: '/auth/example'}),
    function (req, res) {
        dal.User.count({
            authschId: req.user.internal_id
        }, function( err, count){
            console.log( "Number of users:", count );
            if(!count) {
                dal.User.create({
                    authschId: req.user.internal_id,
                    name: req.user.displayName,
                    email: req.user.email,
                    avatar: 'default.jpg',
                    admin: false
                }, function () {
                    res.redirect('/oldal/welcome');
                });
            } else {
                res.redirect('/');
            }
        });
    });

module.exports = router;
