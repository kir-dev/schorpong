var hasTeam = function (id) {

    return function (req, res, next) {
        dal.Membership.findOne({
            user: currentUser
        }).populate({ path: 'team', select: 'name' }).then(function(membership) {
            if(membership) {
                return res.redirect('/csapatok/' + membership.team._id);
            } else {
                return res.redirect('/csapatok/new');
            }
        });

    };
};

module.exports = hasTeam;
