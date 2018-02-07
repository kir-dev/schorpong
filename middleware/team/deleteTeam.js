var deleteTeam = function (id) {

    return function (req, res, next) {
        dal.Team.findById(req.params.id).remove(function (team) {
            return next();
        });
    };
};

module.exports = deleteTeam;
