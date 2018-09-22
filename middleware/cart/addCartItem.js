var addCartItem = function (id) {

    return function (req, res, next) {
        dal.Cart.findOne({
            user: currentUser,
            checkedOut: false
        }).exec((err, cart) => {
            if (cart) {
                var item = cart.items.find(function(item) {
                    return item.tool == req.params.id;
                });
                if(item) {
                    item.amount += parseInt(req.body.amount);
                } else {
                    cart.items.push({tool: req.params.id, amount: req.body.amount});
                }
                cart.save(err => {if(err) return next(err);});
                return next();
            } else {
                dal.Cart.create({
                    checkedOut: false,
                    gaveOut: false,
                    tookIn: false,
                    items: [{tool: req.params.id, amount: req.body.amount}],
                    user: currentUser
                }), function (err, cart) {
                    if (err) return next(err);
                    return next();
                };
            }
            return next();
        });
    };
};

module.exports = addCartItem;
