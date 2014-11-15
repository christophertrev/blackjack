class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .dealagain': -> @model.get('game').newDeal()

  initialize: ->
    @render()
    @model.get('game').on 'gameOver', =>
      @renderGameOver()

  render: ->
    # debugger
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderGameOver: ->
    button = $('<button>').text('Deal Again?').addClass('dealagain')
    button.on 'click', @redealRender.bind @
    $('body').prepend $('<div>').addClass('restart').text('GAMEOVER').append button

  redealRender: ->
    # debugger
    @model.get('game').newDeal()
    @model.reset()
    @render()
    $('.restart').remove()
