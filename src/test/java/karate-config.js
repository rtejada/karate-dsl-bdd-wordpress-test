function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
      urlBase: 'http://192.168.1.59:8000/wordpress/wp-json/wp/v2/'
      /*appId: 'my.app.id',
      appSecret: 'my.secret',
      someUrlBase: 'https://some-host.com/v1/auth/',
      anotherUrlBase: 'https://another-host.com/v1/'*/
    };
    if (env == 'stage') {
      // over-ride only those that need to be
      config.someUrlBase = 'https://stage-host/v1/auth';
    } else if (env == 'e2e') {
      config.someUrlBase = 'https://e2e-host/v1/auth';
    }
    // don't waste time waiting for a connection or if servers don't respond within 5 seconds
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);

      var temp = 'roxana' + ':' + '75gpJQXSuLSsNzM';
      var Base64 = Java.type('java.util.Base64');
      var encoded = Base64.getEncoder().encodeToString(temp.bytes);

    karate.configure('headers', {Authorization: 'Basic ' + encoded})

    return config;

}