# @steveruizok

# Integrate a PageComponent to view user photos.

Screen.backgroundColor = '#efefef'
scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
	contentInset:
		bottom: 32

class Card extends Layer
	constructor: (options = {}) ->
		
		# PROPERTIES
		
		@_userName = options.name ? 'Default User'
#		[1] change @_userImage to @_userImages, and set the default to an array of three images
		@_userImages = options.photos ? [
			Utils.randomImage(), 
			Utils.randomImage(), 
			Utils.randomImage()
			]
		@_userJoined = options.joined ? 2010
		@_userDescription = options.description ? 'User Name is a new user for our platform.'
		@_userStarred = options.starred ? false
		
		
		# LAYERS
		
		super _.defaults options,
			name: @_userName, parent: scroll.content
			x: Align.center, y: 32
			width: 192, height: 288
			borderRadius: 8
			backgroundColor: '#FFF'
			shadowColor: 'rgba(0,0,0,.2)', shadowX: 1, shadowY: 2
			shadowSpread: 2, shadowBlur: 6
			clip: true
		
#		[2] change @userImage to @userImagePager, a PageComponent
		@userImagePager = new PageComponent
			name: 'userImage', parent: @
			width: @width, height: @width
			scrollVertical: false
			
		@userImagePager.content.draggable.overdrag = false

		@userName = new TextLayer
			name: 'userName', parent: @
			x: 16, y: @userImagePager.maxY + 8
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
			x: Align.right(-12), y: @userImagePager.maxY
			fontSize: 28
			text: '✩', textAlign: 'right'
		
		# EVENTS
		
		# when star is tapped, run toggleStarredStatus
		@star.onTap => @toggleStarredStatus()
	
		# ON LOAD
		
		# when loaded, set user images...
		@setUserImages()
		
		# and then run updateStar
		@updateStar()
	
	# FUNCTIONS
	
	# switch the value of @_userStarred and run updateStar
	toggleStarredStatus: ->
		@_userStarred = !@_userStarred
		@updateStar()
	
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

	# add user images to user image pager
	setUserImages: ->
		for image, i in @_userImages
			imagePage = new Layer
				size: @userImagePager.size
				image: @_userImages[i]
			
			@userImagePager.addPage(imagePage)


# INSTANCES

card1 = new Card

card2 = new Card
	y: card1.maxY + 32
	name: 'Susan Richards'
	photos: ['images/user_image_1.png', Utils.randomImage(), Utils.randomImage()]
	joined: 2007
	description: 'Susan is an aspiring beat philanthropist, top notch.'
	starred: true

card3 = new Card
	y: card2.maxY + 32
	name: 'Judy Sanchez'
	photos: ['images/user_image_2.png', Utils.randomImage(), Utils.randomImage()]
	joined: 2007
	description: 'Judy is a wax philosopher with some insoluble ideas.'
	starred: false
	
	