class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'add', => @checkPlayerScore()
    @get('dealerHand').on 'add', => @checkDealerScore()
    # deck.on 'remove', => @checkScores()

  checkPlayerScore: ->
    player = @get 'playerHand'
    playerScore = player.scores()[0]
    if playerScore > 21 then @loseGame()


  checkDealerScore: ->
    dealer = @get 'dealerHand'
    dealerScore = dealer.scores()[0]
    if dealerScore > 21 then @winGame()

  loseGame: ->
    @get('playerHand').lose()

  winGame: ->
    @get('playerHand').win()
