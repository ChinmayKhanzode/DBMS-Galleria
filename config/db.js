const mongoose = require('mongoose')

console.log("insinde");

const connection = mongoose.createConnection('mongodb+srv://chinmay:AaOtBYEM00XspUsv@cluster0.g3qee5d.mongodb.net/').on('open',()=>{
    console.log("Mongose connection succesfull");
}).on('error',()=>{
    console.log("errorr has occured");
})

module.exports = connection;