var canJoinTeam = function (id) {

    return function (req, res, next) {
        if(!currentUser.memberships) {
            return next();
        } else if(!currentUser.membership.length < 2) {
            if(!currentUser.memberships.includes(req.body.id)) {
                dal.Membership.count({
                    user: currentUser._id,
                    owner: true
                }, function(err, count){
                    if(!count) {
                        return next();
                    } else {
                        req.flash('warning', 'Tulajdonosa vagy egy csapatnak, így nem csatlakozhatsz másik csapathoz.');
                        res.redirect('/');
                    }
                });
            } else {
                req.flash('warning', 'Ennek a csapatnak már tagja vagy.');
                res.redirect('/');
            }
            return next();
        } else {
            res.redirect('/');
        }
    };
};

module.exports = canJoinTeam;
