// Taken from https://metabox.io/send-get-post-request-with-javascript-fetch-api/#creating-get-and-post-functions

const request = (url, params = {}, method = 'GET') => {
    let options = {
        method
    };
    if ('GET' === method) {
        url += '?' + (new URLSearchParams(params)).toString();
    } else {
        options.body = JSON.stringify(params);
        let csrftoken = getCookie('csrftoken');
        options.headers = { "X-CSRFToken": csrftoken };
    }

    return fetch(url, options).then(response => response.json());
};

const get = (url, params) => request(url, params, 'GET');
const post = (url, params) => request(url, params, 'POST');

// The following function are copied from 
// https://docs.djangoproject.com/en/dev/ref/csrf/#ajax
function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i].trim();
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}