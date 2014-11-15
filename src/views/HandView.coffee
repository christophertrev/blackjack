class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()
    @collection.on 'lose', => @renderLoss()

  render: ->
    if haslost is off then
      @$el.children().detach()
      @$el.html @template @collection
      @$el.append @collection.map (card) ->
        new CardView(model: card).$el
      @$('.score').text @collection.scores()[0]

  renderLoss: ->
    debugger
    name = @$('h2').text()
    @$('h2').text(name + ' Lose!')
    @haslost = true

  haslost: false
