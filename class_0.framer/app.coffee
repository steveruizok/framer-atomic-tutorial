### 
@steveruizok

Example 0: Extending Layer and Customizing Defaults. 


Let's build a class called Card. Once we have the class defined, we can created instances of the class using the new keyword, just as we would with Layer.

First we name our class and state the name of the class we're extending, which is Layer (1).

Next we begin the constructor function (2). Each class has a special function called constructor, which will run automatically when an instance of the class is created. If we imagine the class as a factory, then the constructor is the assembly line: it starts with the base class (in our case, Layer) and makes various changes - adjusting properties like size and color, bolting on additional layers, and setting event listeners. When it finishes, the instance will appear in our project fully constructed according to the instructions we've provided.

Like any function, the constructor takes arguments. Since we're extending Layer, we'll use the same arguments that Layer instances use: an object called options, made up of key value pairs for different properties of the Layer.

	icon1 = new Layer
		x: 100, y: 100  			|
		borderRadius: 50			| options object
		backgroundColor: 'red'		|
		
		
		
When a layer is created (or, we could say, when the Layer class is instantiated) this options object is passed as an argument to Layer's constructor function. The constructor uses these values to over-ride Layer's default properties as it constructs the layer instance. In the example above, the properties x, y, borderRadius, and backgroundColor would all be over-ridden using the values we provided. Layer's constructor would set all of the layer instance's other properties (like height and width) using its defaults instead.

In our new class, we can customize Layer's defaults with our own values. We invoke Layer using the keyword super, then tell Layer to run the _.defaults function, changing the defaults for the options object passed as an argument to the constructor (3) using the new options object that we provide (4).

This is really useful: it will allow us to skip these lines when creating our instance. For example, if we had a project with one hundred identical icons, rather than stating that every icon has a height and width of 100 and a borderRadius of 50, we could define a class called Icon with these properties as its defaults, and we could leave these lines out when we create a new Icon. What's better, if we later decided that Icon should only have a borderRadius of 25, we would only have to change the defaults in the class, as these changes would be reflected in all of the icon instances.

Now, when we create instances of Card, any properties left undefined in our options object will default to the options we set in (4). We can see those defaults in our first instance (5), where we haven't provided any options at all. Rather than using Layer's defaults to fill in the blanks, it's used our custom defaults instead.

Just like Layer's regular defaults, our custom defaults can be over-riden by the instance's options argument. In our second instance (6), we've set the instance's y value. This over-rides our custom default for the y property.
###

Screen.backgroundColor = '#efefef'

# CLASS

# [1] make a new class named Card that extends Layer
class Card extends Layer					
# 	[2] the constructor takes an options argument, just like Layer
	constructor: (options = {}) ->			
#		[3] change Layer's default options...
		super _.defaults options,			
#			[4] using this options object
			x: Align.center, y: 32			 
			width: 192, height: 288			
			borderRadius: 8					
			backgroundColor: '#FFF'			 
			shadowColor: 'rgba(0,0,0,.2)'	
			shadowX: 1, shadowY: 2			
			shadowSpread: 2, shadowBlur: 6
			clip: true

# INSTANCES

# [5] our first instance, with an empty options object
card1 = new Card

# [6]	our second instance, set with a y value. This over-rides the
#		custom defaults we set in our class.
card2 = new Card
	y: card1.maxY + 32
