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
