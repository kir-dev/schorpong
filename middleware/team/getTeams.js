var getTeams = function (id) {

    return function (req, res, next) {
        dal.Team.find({})
            .populate({
                path: 'memberships',
                select: 'name',
                populate : {
                    path : 'user',
                    select: 'name'
                }
            })
            .then(function (teams) {
                req.teams = teams;
                return next();
            });
    };
};

module.exports = getTeams;
