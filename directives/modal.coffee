###
#	Modal script for angular and greensock
#	TODO: write some documentation and comment code
###

modal       = angular.module 'modal', []

isOpen      = false
modalElem   = null
overlayElem = null
rootScope	= null

angular.element(document).ready ->
	modalElem   = document.getElementById 'modal'
	overlayElem = document.getElementById 'overlay'
	modalScope 	= angular.element(modalElem).scope()

injectdeject 	= (content) ->
	content ?= null
	modalScope.modalTpl = content
	modalScope.$apply()

open 	= (attrs) ->
	return if isOpen # return early
	isOpen = true

	modalElem.style.width  		= 0
	modalElem.style.height 		= 0
	overlayElem.style.display 	= 'block'	

	TweenLite.to modalElem, 0.45, 
		height		: attrs.height
		width		: attrs.width
		opacity		: 1		
		marginTop 	: attrs.height / -2
		marginLeft 	: attrs.width / -2
		ease 		: Back.easeOut

	TweenLite.to overlayElem, 0.45,
		opacity 	: 1

	injectdeject attrs.content

close 	= ->
	return unless isOpen # return early
	isOpen = false

	TweenLite.to modalElem, 0.33,
		width		: 0
		height		: 0
		marginTop	: 0
		marginLeft	: 0
		opacity		: 0
		ease 		: Cubic.easeOut

	TweenLite.to overlayElem, 0.33,
		opacity 	: 0
		onComplete	: ->
			overlayElem.style.display = 'none'
			injectdeject()
			

modal.directive 'openmodal', ->
	(scope, element, attrs) ->
		element.bind 'click', -> open attrs

modal.directive 'closemodal', ->
	(scope, element, attrs) ->
		element.bind 'click', -> close()


