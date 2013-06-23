var dashing = require('dashing-js').Dashing();

// Set your auth token here
dashing.auth_token = '1a2b3c4d5e6f';

// Set cors allowed domains here
//dashing.allowedOrigins = 'https://www.google.com';

/*
dashing._protected = function(req, res, next) {
  // Put any authentication code you want in here.
  // This method is run before accessing any resource.
  // if (true) next();
}
*/

// Set your default dashboard here
//dashing.default_dashboard = 'mydashboard';

dashing.start();
