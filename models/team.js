module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Team = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        name: String,
        points: { type: Number, default: 0 },
        memberships: [{type: Schema.Types.ObjectId, ref: 'Membership'}]
    }, {timestamps: true});

    return Team;
};
