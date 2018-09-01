var addCartItem = function (id) {

    return function (req, res, next) {
        if(req.body.amount == 0) {
            dal.Cart.findOneAndUpdate({
                user: currentUser,
                checkedOut: false
            }, {$pull: {items: {tool: req.params.id}}}, (err, res) => {})
        } else {
            dal.Cart.findOne({
                user: currentUser,
                checkedOut: false
            }).exec((err, cart) => {
                if (cart) {
                    var item = cart.items.find(function(item) {
                        return item.tool == req.params.id
                    });
                    if(item) {
                        item.amount = parseInt(req.body.amount)
                    }
                    cart.save(err => {if(err) return next(err)})
                    return next();
                }
                return next();
            });
        }
    };
};

module.exports = addCartItem;
