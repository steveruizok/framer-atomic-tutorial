# @steveruizok

# Example 3: Getting information into a class

Screen.backgroundColor = '#efefef'

class Card extends Layer
	constructor: (options = {}) ->
		
		# PROPERTIES
		
# 		[1] while we primarily use the options object to set our defaults, we can also use it to get other information into the class. We do this by defining properties of the instance using properties of the options object.
		@_userName = options.name
		
# 		[2]
		@_userImage = options.photo ? Utils.randomImage()

# 		[2] We can also set defaults for the properties we create by using
# 			the existential operator. For example, if an instance of this
# 			class is created without a stated photos property, the
# 			instance._userImage will instead set with a random image.
		@_userJoined = options.joined ? 2010
		@_userDescription = options.description ? 'User Name is a new user for our platform.'
		
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
			x: Align.right(-16), y: @userImage.maxY + 8
			fontSize: 18
			text: '✩', textAlign: 'right'

card1 = new Card

card2 = new Card
	y: card1.maxY + 32
	name: 'Susan Richards'
	photo: 'images/user_image_1.png'
	joined: 2007
	description: 'Susan is an aspiring beat philanthropist, top notch.'
	
	