var requireAdmin = function () {

  return function (req, res, next) {
      if(req.isAuthenticated()) {
          dal.User.findOne({authschId: req.user.internal_id}).then(function (user) {
              if (user !== null && user.admin) {
                  return next();
              } else if (req.user !== null) {
                  return next(new Error('Unauthorized'));
              } else {
                  res.redirect('/login');
              }
          });
      }
  };

};

module.exports = requireAdmin;
