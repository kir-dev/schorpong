module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Cart = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        checkedOut: Boolean,
        gaveOut: Boolean,
        tookIn: Boolean,
        items: [{
            tool: {type: Schema.Types.ObjectId, ref: 'Tool'},
            amount: {type: Number, min: 0, required: true}
        }],
        user: {
            type: Schema.Types.ObjectId,
            ref: 'User'
        }

    }, {timestamps: true});

    Cart.virtual('date').get(function() {
        return moment(this.createdAt).format("YYYY-MM-DD HH:mm");
    });


    return Cart;
};