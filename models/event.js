module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Event = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        name: String,
        image: String,
        description: String
    }, {timestamps: true});

    Event.virtual('datettt').get(function() {
        moment.locale('hu-HU');
        return moment(this.date).fromNow();
    });
    return Event;

};{}
