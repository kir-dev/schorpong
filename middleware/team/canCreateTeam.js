var canCreateTeam = function (id) {

    return function (req, res, next) {
        if(!currentUser.memberships) {
            return next();
        } else {
            req.flash('warning', 'Nem hozhatsz létre csapatot, mert már tagja vagy egy csapatnak.');
            res.redirect('/');
        }
    };
};

module.exports = canCreateTeam;
