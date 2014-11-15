class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()
    @collection.on 'lose', =>
      @haslost = true
      @render()
    , @
    @collection.on 'win', =>
      @hasWon = true
      @render()
    , @

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    if @haslost then @renderLoss()
    if @hasWon then @renderWin()

  renderLoss: ->
    name = @$('h2').text()
    @$('h2').text(name + ' Lose!')

  renderWin: ->
    name = @$('h2').text()
    @$('h2').text(name + ' Win!')

  haslost: false

  hasWon: false
