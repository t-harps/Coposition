/* exported utility */


window.COPO = window.COPO || {};

COPO.utility = {

  deselect() {
    if (window.getSelection) {
      if (window.getSelection().empty) {  // Chrome
        window.getSelection().empty();
      } else if (window.getSelection().removeAllRanges) {  // Firefox
        window.getSelection().removeAllRanges();
      }
    } else if (document.selection) {  // IE?
      document.selection.empty();
    }
  },
  urlParam(name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (!results) return null;
    return results[1] || 0;
  },

  ujsLink(verb, text, path) {
    var output =  $('<a data-remote="true" rel="nofollow" data-method="' + verb +'" href="' + path +'">' + text +'</a>')
    return output
  },

  deleteCheckinLink(checkin) {
    return COPO.utility.ujsLink('delete',
      '<i class="material-icons right red-text">delete_forever</i>' ,
      window.location.pathname + '/checkins/' + checkin.id )
      .attr('class', 'right').attr('data-confirm', 'Are you sure?').prop('outerHTML')
  },

  fogCheckinLink(checkin, foggedClass, fogId) {
    return COPO.utility.ujsLink('put',
      '<i class="material-icons">cloud</i>' ,
      window.location.pathname + '/checkins/' + checkin.id )
      .attr('id', fogId + checkin.id).attr('class', foggedClass).prop('outerHTML')
  },

  geocodeCheckinLink(checkin) {
    return COPO.utility.ujsLink('get',
      'Get address' ,
      window.location.pathname + '/checkins/' + checkin.id )
      .prop('outerHTML')
  },

  createCheckinLink(coords) {
    var checkin = {
      'checkin[lat]': coords.lat.toFixed(6),
      'checkin[lng]': coords.lng.toFixed(6)
    }
    var checkinPath = location.pathname + '/checkins?' + $.param(checkin);
    return COPO.utility.ujsLink('post', 'Create checkin here', checkinPath).prop('outerHTML');
  },

  friendsName(friend) {
    return friend.username ? friend.username : friend.email.split('@')[0]
  },

  fadeUp(target) {
    $(target).velocity({
      opacity: 0,
      marginTop: '-40px'
    }, {
      duration: 375,
      easing: 'easeOutExpo',
      queue: false,
      complete() {
        $(target).remove();
      }
    });
  },

  avatar(avatar, options) {
    options = $.extend(this.avatarDefaults, options)
    if(avatar) {
      return $.cloudinary.image(avatar.public_id, options).prop('outerHTML')
    }
  },

  avatarUrl(avatar, options) {
    options = $.extend(this.avatarDefaults, options)
    if(avatar) {
      return $.cloudinary.url(avatar.public_id, options)
    }
  },

  avatarDefaults: {"transformation":["60x60cAvatar"],"format":"png"},

  initClipboard(selector, callback) {

    selector = selector || '.clip_button';
    var client = new ZeroClipboard( $(selector) );

    client.on( 'ready', function(event) {
      // console.log( 'movie is loaded' );
      $('.clip_button').removeClass('hide');

      client.on( 'copy', function(event) {
        event.clipboardData.setData('text/plain', event.target.value);
      });

      callback = callback || function(event) {
        $('.material-tooltip').children('span').text('Copied');
      }

      client.on( 'aftercopy', function(event) {
        callback(event);
      });

    });

    client.on( 'error', function(event) {
      console.log( 'ZeroClipboard error of type "' + event.name + '": ' + event.message );
      ZeroClipboard.destroy();
    });
  },

  gonFix() {
    var contents = $('#gonvariables').html();
    $('#gonvariables').html(contents);
  },

  commaToNewline(string) {
    return string.replace(/, /g, '\n')
  },

  geoLocationError(err) {
    Materialize.toast('Could not get location', 3000)
  },

  pluralize(noun, count) {
    if(count > 1) return noun + 's';
    return noun;
  }
};
