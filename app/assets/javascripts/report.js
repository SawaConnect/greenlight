// BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
//
// Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
//
// This program is free software; you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free Software
// Foundation; either version 3.0 of the License, or (at your option) any later
// version.
//
// BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
// PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License along
// with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

// Room specific js for copy button and email link.
$(document).ready(function(){
  var controller = $("body").data('controller');
  var action = $("body").data('action');
  $('.meetings-data').hide()
  $('.attendee-data').show()
  $('.attendees').hide()
  $('.polls').hide()
  $('.overview').show()
  $('.attention-card').click(function(){
    $('.meetings-data').hide()
    $('.attendee-data').show()
    $('.attendees').show()
    $('.polls').hide()
    $('.overview').hide()
  })
  $('.poll-card').click(function(){
    $('.meetings-data').hide()
    $('.attendee-data').show()
    $('.attendees').hide()
    $('.polls').show()
    $('.overview').hide()
  })
  $('.overview-card').click(function(){
    $('.meetings-data').hide()
    $('.attendee-data').show()
    $('.attendees').hide()
    $('.polls').hide()
    $('.overview').show()
  })
  // highlight current room
  if (controller == "reports" && action == "show"){
    $('#tooltipmodals').on('show.bs.modal', function(e){
      path = $(e.relatedTarget).data('item-url')
      $('#tooltipmodals .modal-content').load(path)
    })

  }

  if (controller == "rooms" && action == "analytics"){
    $('#meetings-table').on('click', 'tbody td', function(){
      console.log("table")
      if($(this).attr("data-href")){
        window.location = $(this).attr("data-href");
      }
    })
  }
})
