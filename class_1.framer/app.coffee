# @steveruizok

# Example 3: Adding Layers

Screen.backgroundColor = '#efefef'

class Card extends Layer
	constructor: (options = {}) ->
		super _.defaults options,
			x: Align.center, y: 32
			width: 192, height: 288
			borderRadius: 8
			backgroundColor: '#FFF'
			shadowColor: 'rgba(0,0,0,.2)', shadowX: 1, shadowY: 2
			shadowSpread: 2, shadowBlur: 6
			clip: true
		
		# LAYERS
		
#		[1]	add our first layer to this class, a user image. We set its
#			parent to @, which will be the instance of Layer that will use
#			the defaults we defined above.
		userImage = new Layer
			name: 'userImage', parent: @
			width: @width, height: @width
			image: Utils.randomImage()

# 		[2] we can refer to the layers we make within the constructor in,
# 			for example to set the second layer's y position relative to the 
# 			bottom of the first layer.
		userName = new TextLayer
			name: 'userName', parent: @
			x: 16, y: userImage.maxY + 8
			fontSize: 16, fontWeight: 600, color: '#000'
			text: 'User Name'
		
# 		[3] a word of caution: just like any variables that you create 
# 			within a function, these variables won't be accessible from
# 			outside of it. Check the examples at bottom of this project. 
# 			Outside of the constructor, userDetail will throw a Reference 
# 			Error.
		userDetail = new TextLayer
			name: 'userDetail', parent: @
			x: 16, y: userName.maxY + 2
			fontSize: 10, fontWeight: 400, color: '#777'
			text: 'Member since 2017'
		
# 		[4] the solution is to define layers as properties of the instance. 
# 			Remember that Layers are objects, and objects can have 
# 			properties, and those properties can be (among other things) 
# 			other objects, including Layers. Since the instance will be in
#			the global namespace, it - and its properties - will be
#			accessible everywhere.
		@userDescription = new TextLayer
			name: 'userDescription', parent: @
			x: 16, y: userDetail.maxY + 8
			width: @width - 32
			fontSize: 12, color: '#333'
			text: 'User Name is a new user for our platform.'
		
# 		[5] in the following examples, we'll stick with adding layers as 
# 			properties. Be careful not to use a layer name that conflicts 
# 			with a standard layer name: for example, @scroll would make a 
# 			bad name for a scrollComponent, since Layer.scroll is an 
# 			existing property.
		@star = new TextLayer
			name: 'star', parent: @
			x: Align.right(-16), y: userImage.maxY + 8
			fontSize: 18
			text: '✩', textAlign: 'right'

card1 = new Card

card2 = new Card
	y: card1.maxY + 32

# ReferenceError: Can't find variable: star
# print userDetail

# » undefined
# print card1.userDetail 

# » <TextLayer id:5 name:userDescription (16, 242) 160x30>
# print card1.userDescription 
 