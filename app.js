var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
require('dotenv').config();

var passport = require('passport'),
    OAuth2Strategy = require('passport-oauth2');
var session = require('express-session');
var flash = require('express-flash');

var authorizationRoutes = require('./routes/auth');
var index = require('./routes/index');
var articles = require('./routes/articles');
var pages = require('./routes/pages');
var teams = require('./routes/teams');
var tools = require('./routes/tools');
var events = require('./routes/events');
var cart = require('./routes/cart');
var entries = require('./routes/entries');
var users = require('./routes/users');
var errors = require('./routes/errors');

var app = express();
var dal = require('./models/mongo.js');
var moment = require('moment');
moment.locale('hu-HU');
var currentUser = {};

// view engine setup
app.engine('ejs', require('ejs-locals'));
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/bower_components',  express.static(__dirname + '/bower_components'));

//Auth

app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: true,
    saveUninitialized: true,
    cookie: {secure: false}
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

passport.use(new OAuth2Strategy({
    authorizationURL: 'https://auth.sch.bme.hu/site/login',
    tokenURL: 'https://auth.sch.bme.hu/oauth2/token',
    clientID: process.env.AUTHSCH_CLIENT_ID,
    clientSecret: process.env.AUTHSCH_CLIENT_SECRET,
    callbackURL: '/auth/example/callback',
    scope: ['basic','displayName','mail','roomNumber']
},
function (accessToken, refreshToken, profile, cb) {
    console.log(accessToken + '\n' + refreshToken + '\n' + JSON.stringify(profile));
    var request = require('request');
    request('https://auth.sch.bme.hu/api/profile?access_token=' + accessToken, function (error, response, body) {
        if (!error && response.statusCode == 200) {
            return cb(null, JSON.parse(body), null);
        } else {
            return cb(new Error('hello'));
        }
    });
}));


app.use(function (req, res, next) {
    res.locals.logged_in = req.isAuthenticated();
    res.locals.is_admin = false;

    //TODO: DO IN MIDLEWARE
    if(req.isAuthenticated()){
        dal.User.findOne({
            authschId: req.user.internal_id
        }).populate({ path: 'team', select: 'name' }).then(function (user) {
            currentUser = user;
            res.locals.currentUser = currentUser;
            dal.Cart.findOne({
                user: currentUser,
                checkedOut: false,
            }).exec((err, cart) => {
                res.locals.inCart = 0;
                if (cart && cart.items.length) {
                    cart.items.forEach(item => {
                        res.locals.inCart += item.amount;
                    });
                }
                if (user !== null && user.admin) {
                    res.locals.is_admin = true;
                    next();
                } else {
                    res.locals.is_admin = false;
                    next();
                }
            });
        });
    } else {
        next();
    }
});

passport.serializeUser(function (user, done) {
    done(null, user);
});

passport.deserializeUser(function (user, done) {
    done(null, user);
});
app.use('/', index);
app.use('/hirek', articles);
app.use('/oldal', pages);
app.use('/csapatok', teams);
app.use('/eszkozok', tools);
app.use('/kolcsonzes', cart);
app.use('/esemenyek', events);
app.use('/nevezesek', entries);
app.use('/felhasznalok', users);
app.use('/auth', authorizationRoutes);
app.use('/errors', errors);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handler
app.use(function(err, req, res) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

module.exports = app;
