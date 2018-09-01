var canLeaveTeam = function (id) {

    return function (req, res, next) {
        dal.Membership.count({
            team: req.params.id,
            user: currentUser._id,
            owner: true,
        }, function(err, count){
            if(!count) {
                return next();
            } else {
                res.redirect('/');
            }
        });
    };
};

module.exports = canLeaveTeam;
