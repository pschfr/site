# Finds font size of body as rendered
body_size = parseInt(window.getComputedStyle(document.body, null).getPropertyValue('font-size').replace('px', ''))
# Logs font size if stored in localStorage
if localStorage.getItem('font-size')
	body_size = localStorage.getItem('font-size')
	document.body.style.fontSize = body_size + "px"

changeFontSize = (direction) ->
	# do da maths
	if direction == 'up'
		body_size = parseInt(body_size) + 1
	else if direction == 'down'
		body_size = parseInt(body_size) - 1
	else if direction == 'reset'
		body_size = 17
	# sets body font size
	document.body.style.fontSize = body_size + "px"
	# save to localStorage
	localStorage.setItem('font-size', body_size)

toTop = () ->
	# Unfocuses the link tag
	tempInput = document.createElement('input')
	document.body.appendChild(tempInput)
	tempInput.focus()
	document.body.removeChild(tempInput)
	# Scrolls to the top-left pixel
	window.scrollTo(0, 0)

# https://github.com/pschfr/LastFM.js
lastFM_request = (username, API_key, number, elementID) ->
	lastFMurl = 'https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=' + username + '&api_key=' + API_key + '&limit=' + number + '&format=json'
	xmlhttp = new XMLHttpRequest()
	xmlhttp.open('GET', lastFMurl, true)
	xmlhttp.onreadystatechange = () ->
		if xmlhttp.readyState == 4 && xmlhttp.status == 200
			track = JSON.parse(xmlhttp.responseText).recenttracks.track[0]
			document.getElementById(elementID).innerHTML = '<a href="' + track.url + '" target="_blank" rel="noreferrer noopener" title="on the album: ' + track.album['\#text'] + '">' + track.name + ' by ' + track.artist['\#text'] + '</a>.'
		else
			document.getElementById(elementID).innerHTML = 'nothing, apparently. It appears the connection to Last.fm failed. :('
	xmlhttp.send(null)

# if on home page, make Last.fm request
if window.location.pathname.replace('/', '') == '' or window.location.pathname.replace('/', '') == 'v2/'
	setInterval(lastFM_request('paul_r_schaefer', '0f680404e39c821cac34008cc4d803db', '1', 'currentlylistening'), 5000)
else if window.location.pathname.replace('/', '') == 'contact' # if contact page...
	# Show thanks or error messages
	if window.location.search.replace('?', '') == 'thanks'
		document.getElementsByTagName('form')[0].style.display = 'none'
		document.getElementsByTagName('form')[0].parentElement.appendChild(document.createElement('p')).innerHTML = 'Thanks for your message! I\'ll get back to you right away.<br/><br/>Go back <a href="/">home</a>, or read some <a href="/articles">articles</a>.'
	else if window.location.search.replace('?', '') == 'error'
		document.getElementsByTagName('form')[0].parentElement.appendChild(document.createElement('p')).innerHTML = 'It seems something went wrong. Please try sending your message again.'
