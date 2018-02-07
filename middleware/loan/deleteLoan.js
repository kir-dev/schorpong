var deleteLoan = function (id) {

    return function (req, res, next) {
        dal.Loan.findById(req.params.id).remove(function (tool) {
            return next();
        });
    };
};

module.exports = deleteLoan;
