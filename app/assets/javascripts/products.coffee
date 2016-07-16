# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
renewBid =(bid) ->
	$('#highest_bid').text(bid)
renew_bidder_count(count) ->
  $('#number_of_bids')

gon.watch('highest_bid', interval: 1000, renewBid )
gon.watch('number_of_bids', interval: 1000, renew_bidder_count)
