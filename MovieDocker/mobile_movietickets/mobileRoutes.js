/**
 * Created by gabriella.querales on 12/30/15.
 */
//var env = require('./process.env')
var request= require("request")
var http = require('http');

// Redis
var redis = require('redis');
var clientR = redis.createClient('6379','nodemobile_redis'); //creates a new client

clientR.on("error", function (err) {
    console.log("Error " + err);
});

clientR.on('connect', function() {
    console.log('connected');
});

// MongoDB
var mongoose = require('mongoose');
var url = 'nodemobile_mongodb'
mongoose.connect(url).connection;

var Schema = mongoose.Schema; // <-- EDIT: missing in the original post
var User = new Schema({
    first_name:String,
    last_name:String,
    email:String,
    picture:String,
    pref_movie:String,
    address :{
        street: String,
        city: String,
        state: String
    }
})

mongoose.model ('Users',User)
var Users =mongoose.model('Users',User);

module.exports = function(app) {
    //Load the Db with data in the data file
  app.get('/loadDB', function (request, response) {
        var users = require('./data.json');
        users.forEach(function(u){
            var user = new Users(u);
            user.save(function(err) {
                if (err){
                    console.log ("something bad happened!!!!!");
                    console.log (err);
                }
                console.log ("user "+u.first_name+" was added!!!!");
            })

        });
        // it may not be in the righ place to close the BT but it donset matter bc this is not part of demo
        response.send("DB was loaded!!");
    })

    // this hook is to test the event loop snapshot. It takes 5 seconds to execute (slow process)
    app.get('/recommendations', function (request, response) {
        process.nextTick(function () {
            userPref(
                function() { httpCall (function() {response.send('done recommendations!!')})}
            )

        })
    })

    // 2 http calls and 1 db call
    app.get('/userExperience', function (req, response) {
       //console.log("headers ---------------------> " + JSON.stringify(req.headers));
        var userName = req.query.first_name;
        if (!userName) userName = {'first_name': 'Andrew'};
        // make the db call slower by passing a REGEX parameter to search by
       Users.find(userName,function (err, person) {
                    if (err) return handleError(err);
          // console.log('Found this person: --> (1) ',person)
           console.log('Found this person: --> (1) ')
           httpCall(function () {
               //call redis endpoint
               funcRedis( function (){ console.log("this should be the last call, closing bt here.... (4)")
                   response.send('done userExp yay!!')})

           })
        })


    })
    //end UserExperience

    //depending on parm will do a slow db call
    app.get('/lookupUser', function (request, response) {
        var userName = request.query.first_name;
        if (!userName) var userData = {first_name:'Howard'};
        else userData = {first_name:userName};
        console.log("user first name is: 0 from lookupUser "+userData.first_name)
        lookupUserSlow (userData, function (msg) {
          // var msg= "done --> lookupUser";
            response.send(msg)}
        )})


} // end of all endpoints




//**********************************
// Internal functions go here     //
//**********************************

// this function takes 5 seconds.
function userPref(CB) {
    var functions= require('./preferences.js');
    functions.socialProfile("Ryan Gosling");
    functions.moviesRated("Ryan Gosling");
    functions.ticketsBought("Ryan Gosling");
    functions.favActors("Ryan Gosling");
    functions.moviesQueue("Ryan Gosling");
    CB();

}


// Finds an user. It does a slow query if "complex" is passed as parm in the first_name
// this function will do a slow DB call
function lookupUserSlow(user,endTran) {
    console.log("user first name is: 2 "+user.first_name)

    if (user.first_name!="complex") {
        console.log ("here---->"+user.first_name)
        var conditions = { "first_name": user.first_name},
            options = { multi: false};
        var message="end tran simple!!"
    }
    else {
        console.log ("here---->complex")
        var Regex=new RegExp(/^[A-Za-z][A-Za-z0-9]*(?:_[A-Za-z0-9]+)*$/)
        var conditions = { "first_name": Regex},
        options = { multi: false};
        var message="end tran complex!!"


    }

    Users.find(conditions, options, function(err,person) {
        //    console.log('Found and updated to this last name: 3 '+ person)
        console.log('about to end Tran for finding person 4')
        endTran(message) });


}


// Call Web Services 
//

function httpCall(BT) {                                                                                                    
   
//    request("http://api.partner.imdb.com", function () {console.log("IMDB call 2.0") })                                       

   
  //  request("http://api.twitter.com", function () {console.log("Twitter call 2.1") })                                      


   // request("http://maps.googleapis.com", function () { console.log("Google")                                              

     //                                             BT()                                                                     
//                                                })                                                                         


    request('http://api.twitter.com', function(){console.log(" 1")})
    request('http://MOVIE_TIX/Movie/Search/', function() {
            console.log(" 2")
            request('http://maps.googleapis.com', function() { console.log(" should be last....")
                                                                    BT()})
            }
    )




}




function funcRedis (CB) {
    console.log("redis.......... 3")


    clientR.set('framework', 'AngularJS', function(err, reply) {
        console.log('RedDis client set 3.1');
        CB()
    });

}
