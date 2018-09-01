var joinTeam = function (id) {

    return function (req, res, next) {
        dal.Membership.create({
            team: req.params.id,
            user: currentUser,
            active: false,
            owner: false
        }, function (membership) {
            res.redirect('/csapatok/csapatom');
        });
    };
};

module.exports = joinTeam;
