# @steveruizok

Screen.backgroundColor = '#efefef'

class Card extends Layer
	constructor: (options = {}) ->
		
		# PROPERTIES
		
		@_userName = options.name ? 'Default User'
		@_userImage = options.photo ? Utils.randomImage()
		@_userJoined = options.joined ? 2010
		@_userDescription = options.description ? 'User Name is a new user for our platform.'
		@_userStarred = options.starred ? false
		
		# LAYERS
		
		super _.defaults options,
			name: @_userName
			x: Align.center, y: 32
			width: 192, height: 288
			borderRadius: 8
			backgroundColor: '#FFF'
			shadowColor: 'rgba(0,0,0,.2)', shadowX: 1, shadowY: 2
			shadowSpread: 2, shadowBlur: 6
			clip: true
		
		@userImage = new Layer
			name: 'userImage', parent: @
			width: @width, height: @width
			image: @_userImage

		@userName = new TextLayer
			name: 'userName', parent: @
			x: 16, y: @userImage.maxY + 8
			fontSize: 16, fontWeight: 600, color: '#000'
			text: @_userName
		
		@userDetail = new TextLayer
			name: 'userDetail', parent: @
			x: 16, y: @userName.maxY + 2
			fontSize: 10, fontWeight: 400, color: '#777'
			text: "Member since #{@_userJoined}"
		
		@userDescription = new TextLayer
			name: 'userDescription', parent: @
			x: 16, y: @userDetail.maxY + 8
			width: @width - 32
			fontSize: 12, color: '#333'
			text: @_userDescription
		
		@star = new TextLayer
			name: 'star', parent: @
			x: Align.right(-12), y: @userImage.maxY
			fontSize: 28
			text: '✩', textAlign: 'right'
		
		# ON LOAD
		
		# when loaded, run updateStar
		@updateStar()
	
	# FUNCTIONS
	
	# show starred status using @_userStarred
	updateStar: ->
		if @_userStarred is true
			@star.props =
				color: 'rgba(245, 203, 9, 1)'
				text: '★'
		else
			@star.props =
				color: 'rgba(145, 145, 145, 1)'
				text: '✩'


card1 = new Card

card2 = new Card
	y: card1.maxY + 32
	name: 'Susan Richards'
	photo: 'images/user_image_1.png'
	joined: 2007
	description: 'Susan is an aspiring beat philanthropist, top notch.'
	starred: true

card3 = new Card
	y: card2.maxY + 32
	name: 'Judy Sanchez'
	photo: 'images/user_image_2.png'
	joined: 2007
	description: 'Judy is a wax philosopher with some insoluble ideas.'
	starred: false
	
	