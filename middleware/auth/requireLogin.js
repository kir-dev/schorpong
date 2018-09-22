var requireLogin = function () {

    return function (req, res, next) {
        //        if(req.isAuthenticated()) {
        next();
    //    }
        //  res.redirect('/errors/require-login')
    };

};

module.exports = requireLogin;
