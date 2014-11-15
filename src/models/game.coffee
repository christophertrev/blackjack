class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'add', => @checkPlayerScore()
    # @get('dealerHand').on 'add', => @checkDealerScore()
    @get('playerHand').on 'stand', => @continuePlay()
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
    @trigger 'gameOver', @

  winGame: ->
    @get('playerHand').win()
    @trigger 'gameOver', @

  continuePlay: ->
    @get('dealerHand').reveal()
    @get('dealerHand').hit() while @get('dealerHand').scores()[0] < 17
    playerScore = @get('playerHand').scores()[0]
    if playerScore > @get('dealerHand').scores()[0] or @get('dealerHand').scores()[0] > 21 then @winGame() else @loseGame()

  newDeal: ->
    # @set 'deck', deck = new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on 'add', => @checkPlayerScore()
    @get('playerHand').on 'stand', => @continuePlay()
