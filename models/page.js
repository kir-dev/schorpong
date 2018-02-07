module.exports = function(mongoose) {

    var Schema = mongoose.Schema,
        ObjectId = Schema.ObjectId;

    var Page = new mongoose.Schema({
        _id: {
            type: ObjectId,
            default: function f() {
                return new mongoose.Types.ObjectId();
            }
        },
        title: String,
        name: {type: String, unique: true, required: true, dropDups: true},
        content: String
    }, {timestamps: true});

    return Page;
};