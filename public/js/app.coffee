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

lastFM_request = (username, API_key, number, elementID) ->
	lastFMurl = 'https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=' + username + '&api_key=' + API_key + '&limit=' + number + '&format=json'
	xmlhttp = new XMLHttpRequest()
	xmlhttp.open('GET', lastFMurl, true)
	xmlhttp.onreadystatechange = () ->
		if xmlhttp.readyState == 4 && xmlhttp.status == 200
			track = JSON.parse(xmlhttp.responseText).recenttracks.track[0]
			document.getElementById(elementID).innerHTML = '<a href="' + track.url + '" target="_blank" rel="noreferrer noopener" title="on album: ' + track.album['\#text'] + '">' + track.artist['\#text'] + ' &mdash; ' + track.name + '</a>'
		else
			document.getElementById(elementID).innerHTML = 'Sorry, connection to Last.FM failed.'
	xmlhttp.send(null)
setInterval(lastFM_request('paul_r_schaefer', '0f680404e39c821cac34008cc4d803db', '5', 'currentlylistening'), 5000)
