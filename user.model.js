const mongoose = require('mongoose');
const db = require('./config/db');

const {Schema} = mongoose;

const ImageSchema = new Schema({
    _id:mongoose.Schema.Types.ObjectId,
    imgurl:String,
});

const ImageModel = db.model('images',ImageSchema);
console.log('model created');

module.exports = ImageModel;