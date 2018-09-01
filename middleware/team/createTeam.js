var createTeam = function (id) {

    return function (req, res, next) {
        dal.Team.create({
            name: req.body.name,
            description: req.body.description
        }, function (err, team) {
            dal.Membership.create({
                team: team,
                user: currentUser,
                active: true,
                owner: true
            }).then(function (membership) {
                currentUser.memberships.push(membership);
                team.memberships.push(membership);
                team.save();
                currentUser.save();
                return res.redirect('/csapatok/csapatom');
            });
        });
    };
};

module.exports = createTeam;
