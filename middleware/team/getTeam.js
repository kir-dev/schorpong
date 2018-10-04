var getTeam = function (id) {

    return function (req, res, next) {
        dal.Team.findById(req.params.id)
            .populate({
                path: 'memberships',
                select: 'name owner active',
                populate : {
                    path : 'user',
                    select: 'name'
                }
            })
            .then(function (team) {
                req.team = team;
                return next();
            });
    };
};

module.exports = getTeam;
