class window.AppView extends Backbone.View
  template: _.template '
    <div class="scores">Player Score:<%- playerWin %></div>
    <div class="scores">Dealer Score:<%- dealerWin %></div>
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
    $('.difficulty').on 'change', (->
      value = $('.difficulty').val()
      debugger
      switch value
        when 'easy' then @model.get('game').setEasy()
        when 'hard' then @model.get('game').setHard()
        when 'medium' then @model.get('game').setMedium()).bind @
    @model.get('game').on 'gameOver', =>
      playerhand = @$('.player-hand-container').html()
      dealerhand = @$('.dealer-hand-container').html()
      @$el.html @template @model.get('game').attributes
      @$('.player-hand-container').html playerhand
      @$('.dealer-hand-container').html dealerhand
      @renderGameOver()

  render: ->
    # debugger
    @$el.children().detach()
    @$el.html @template @model.get('game').attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderGameOver: ->
    button = $('<button>').text('Deal Again?').addClass('dealagain')
    button.on 'click', @redealRender.bind @
    $('body').append $('<div>').addClass('restart').text('GAMEOVER').append button

  redealRender: ->
    # debugger
    @model.get('game').newDeal()
    @model.reset()
    @render()
    $('.restart').remove()

  renderScore: ->
