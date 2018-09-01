module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Membership = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        owner: Boolean,
        active: Boolean,
        team: { type: Schema.Types.ObjectId, ref: 'Team' },
        user: { type: Schema.Types.ObjectId, ref: 'User' }
    }, {timestamps: true});

    return Membership;
}