var updateUser = function (id) {

    return function (req, res, next) {
        dal.User.findById(req.params.id, function (err, doc){
            doc.name = req.body.name;
            if(req.body.admin == 'on'){
                doc.admin = true;
            } else {
                doc.admin = false;
            }
            doc.save();
            return next();
        });
    };
};

module.exports = updateUser;
