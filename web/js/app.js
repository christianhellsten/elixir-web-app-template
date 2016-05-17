require('web/js/flash')

class App {
  static init() {
    console.debug("App.init")
    // Cookies contain JSON
    $.cookie.json = true;
    // Show username
    let user = $.cookie('user');
    let signedIn = !!user
    if (signedIn) {
      console.debug("Signed in '" + user.email + "'")
      $('#username').html("" + user.email + "")
      $('body').addClass('signed-in')
      $('*[data-user=' + user.id + '] .auth-required').toggle()
    } else {
      console.debug("Not signed in")
      $('body').addClass('signed-out')
    }
	}
}

$(() => {
  App.init()
});
export default App;
