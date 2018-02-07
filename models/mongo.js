var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/schorpong');


var Article = require('./article');
var Entry = require('./entry');
var Event = require('./event');
var Loan = require('./loan');
var Page = require('./page');
var Team = require('./team');
var TeamMembership = require('./teamMembership');
var Tool = require('./tool');
var User = require('./user');

mongoose.model('Article', Article(mongoose));
mongoose.model('Entry', Entry(mongoose));
mongoose.model('Event', Event(mongoose));
mongoose.model('Loan', Loan(mongoose));
mongoose.model('Page', Page(mongoose));
mongoose.model('Team', Team(mongoose));
mongoose.model('TeamMembership', TeamMembership(mongoose));
mongoose.model('Tool', Tool(mongoose));
mongoose.model('User', User(mongoose));

module.exports = mongoose.models;

