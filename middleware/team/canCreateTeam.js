var canCreateTeam = function (id) {

    return function (req, res, next) {
        if(!currentUser.memberships.length) {
            return next();
        } else {
            req.flash('warning', 'Nem hozhatsz létre csapatot, mert már tagja vagy egy csapatnak, vagy folyamatban van a felvételed.');
            res.redirect('/csapatok/lista');
        }
    };
};

module.exports = canCreateTeam;
