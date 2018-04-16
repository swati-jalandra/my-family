App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    message = '<tr class="odd" id="user_1">
               <td class="col col-selectable">
                  <div class="resource_selection_cell">
                      <input type="checkbox" id="batch_action_item_1" value="1" class="collection_selection" name="collection_selection[]">
                   </div>
              </td>
              <td class="col col-name">'+data["chat"]["user"]+'</td>'+
              '<td class="col col-email">'+data["chat"]["message"]+'</td>'+
              '<td class="col col-email">'+data["chat"]["created_at"]+'</td>'+'</tr>'

    $("#message_display").append message
    # Called when there's incoming data on the websocket for this channel

  speak: (message) ->
    user_id = $("#current_user_admin").val()
    @perform 'speak', message: message, user: user_id

$(document).on 'keypress', '#message_content', (event) ->
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value
    event.target.value = ""
    event.preventDefault()

