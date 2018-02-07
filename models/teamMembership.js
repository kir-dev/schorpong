module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var TeamMembership = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        teamId: ObjectId,
        userId: ObjectId
    }, {timestamps: true});

    return TeamMembership;
}