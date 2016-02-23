/**
 * Created by gabriella.querales on 12/30/15.
 */
//var env = require('./process.env')
// AppDyn
require("appdynamics").profile({
    controllerHostName:'CONTROLLER',
    controllerPort:'APPD_PORT', // If SSL, be sure to enable the next line
    accountName:'ACCOUNT_NAME',
    accountAccessKey:'ACCESS_KEY',
    applicationName: 'Movie Tickets Online',
    tierName: 'MobileFront',
    nodeName: 'movieMobile',
    debug:true
});


//open source modules
var express = require('express'),
    app = express();

//configure app routes
var route = require ('./mobileRoutes') (app);

// Make our Express server listen on port 3000.
app.listen(3000);
