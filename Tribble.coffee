#P55
#默认情况下，Tribble 类的属性（除了constructor）都会附加到原型上
#当使用@前缀时，就明确表示我们想要把该属性添加到类对象本身上去
#有@前缀的变量指向的都是实例属性

class Tribble
    constructor: ->
        @isAlive = true
        Tribble.count++
    breed: -> new Tribble if @isAlive
    die: ->
        Tribble.count-- if @isAlive
        @isAlive = false
    @count:0
    @makeTrouble: -> console.log ('Trouble!' for i in [0...@count]).join(' ')

tribble1 = new Tribble
tribble2 = new Tribble
Tribble.makeTrouble()
console.log ''

tribble1.die()
Tribble.makeTrouble()
console.log ''

tribble2.breed().breed().breed()
Tribble.makeTrouble()
