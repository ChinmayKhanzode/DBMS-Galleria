const app = require('./app');

const db = require('./config/db');

const usermodel  = require('./user.model')

const port = 3000;


app.get('/',(req,res)=>{
    res.send("hello world");

})

app.get("/getter",(req,res)=>{
    console.log("woriking");
    usermodel.find({}).then(function(users){
        res.json(users)
    }).catch(function(err){
            console.log(err)
        })
});



app.listen(port,()=>{
    console.log(`server is listening on port http://localhost:${port}`);
})