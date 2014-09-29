#P57

class Shape
    constructor: (@width) ->
    computeArea: -> throw new Error ('I am an abstract class!')

class Square extends Shape
    computeArea: -> Math.pow @width, 2

class Circle extends Shape
    radius: -> @width / 2
    computeArea: -> Math.PI * Math.pow @radius(), 2

showArea = (shape) ->
    unless shape instanceof Shape
        throw new Error('showArea requires a Shape instance!')
    console.log shape.computeArea()

showArea new Square(2)
showArea new Circle(2)
