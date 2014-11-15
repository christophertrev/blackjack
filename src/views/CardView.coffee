class window.CardView extends Backbone.View
  className: 'card'

  tagName: 'img'

  initialize: ->
    @source = 'img/cards/' + @model.get('rankName') + '-' + @model.get('suitName') + '.png'
    @coveredCard = 'img/card-back.png'
    @render()

  render: ->
    @$el.children().detach()
    if @model.get 'revealed' then @$el.attr 'src':@source else @$el.attr 'src':@coveredCard
    @$el.addClass 'covered' unless @model.get 'revealed'


