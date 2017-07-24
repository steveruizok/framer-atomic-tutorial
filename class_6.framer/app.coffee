# @steveruizok

# Add a remove card button.

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
		@_userImages = options.photos ? [Utils.randomImage(), Utils.randomImage(), Utils.randomImage()]
		@_userJoined = options.joined ? 2010
		@_userDescription = options.description ? 'User Name is a new user for our platform.'
		@_userStarred = options.starred ? false
		
# 		[1] - a property to track whether remove button is showing or hidden
		@_removeButtonShowing = false
		
		
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
			fontSize: 26, color: '#333'
			text: '✩', textAlign: 'right'
		
# 		[2] - the remove button layer
		@removeButton = new TextLayer
			name: 'close', parent: @
			x: Align.right(-12), y: 12
			fontSize: 24, color: '#333'
			text: '✕', textAlign: 'right'
			shadowY: 1, shadowY: 1
			shadowColor: 'rgba(255,255,255,.6)'
			scale: .5,
			animationOptions:
				time: .2
		
		@removeButton.states.showing =
			scale: 1
			
		
		# EVENTS
		
		@star.onTap => @toggleStarredStatus()
	
# 		[3] - when closeButton is tapped, show the close button
		@removeButton.onTap => @toggleRemoveButton()
		
		# ON LOAD

		@setUserImages()
		
		@updateStar()
	
	
	# FUNCTIONS
	
	toggleStarredStatus: ->
		@_userStarred = !@_userStarred
		@updateStar()
	
	updateStar: ->
		if @_userStarred is true
			@star.props =
				color: 'rgba(245, 203, 9, 1)'
				text: '★'
		else
			@star.props =
				color: 'rgba(145, 145, 145, 1)'
				text: '✩'
	
	setUserImages: ->
		for image, i in @_userImages
			imagePage = new Layer
				size: @userImagePager.size
				image: @_userImages[i]
			
			@userImagePager.addPage(imagePage)
	
#	[4]	when the remove button is tapped, show the remove button. If it is tapped again,
#		remove the card. If not, after two seconds, reset the remove button.
	toggleRemoveButton: ->
		if @_removeButtonShowing is false
			@removeButton.animate('showing')
			@_removeButtonShowing = true
			
			Utils.delay 2, => 
				@removeButton.animate('default')
				@_removeButtonShowing = false
		else
			@removeCard()
	
#	[5]	remove this Card instance, move Cards below this card up to fill the empty space
#		created, and update the scroll component once the cards have moved
	removeCard: ->
		for sib in @siblings
			if sib.y > @y
				sib.animate
					y: sib.y - @height - 32
					options:
						time: .25
		@destroy()
		Utils.delay .25, -> scroll.updateContent()


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
	
	