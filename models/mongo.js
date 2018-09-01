var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/schorpong');


var Article = require('./article');
var Entry = require('./entry');
var Event = require('./event');
var Page = require('./page');
var Team = require('./team');
var Membership = require('./membership');
var Tool = require('./tool');
var User = require('./user');
var Cart = require('./cart');

mongoose.model('Article', Article(mongoose));
mongoose.model('Entry', Entry(mongoose));
mongoose.model('Event', Event(mongoose));
mongoose.model('Page', Page(mongoose));
mongoose.model('Team', Team(mongoose));
mongoose.model('Membership', Membership(mongoose));
mongoose.model('Tool', Tool(mongoose));
mongoose.model('User', User(mongoose));
mongoose.model('Cart', Cart(mongoose));

module.exports = mongoose.models;

