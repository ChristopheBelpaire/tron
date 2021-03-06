// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or
import {Socket} from "deps/phoenix/web/static/js/phoenix"

let socket = new Socket("/socket")
socket.connect({token: window.userToken})

let registerChannel = socket.channel("register:player", {});
registerChannel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

var Player = function(name, x, y, direction){ return {name: name, x: x, y: y, direction: direction};};
var player1;

$("#register").click(function(){
  var name = $("#name").val();
  player1 = Player(name, 200, 200,0);
  registerChannel.push("register", {body: player1.name});

})

registerChannel.on("register_successfull", payload => {
  $("#registerForm").hide();
});

registerChannel.on("new_user", payload => {
  $("#usersList").append("<li>"+payload.name+"</li>")
});


// Now that you are connected, you can join channels with a topic:
/*
let gameChannel = socket.channel("rooms:lobby", {});
gameChannel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })


//export default socket

var c = document.getElementById("board");
var ctx = c.getContext("2d");





function step(ctx, player, gameChannel ){
  document.onkeydown = function(e) {
    switch (e.keyCode) {
        case 37:
            console.log('left');
            //player.direction = 2;
            gameChannel.push("change_direction", {body: 2});
            break;
        case 38:
            player.direction = 3;
            //console.log('up');
            gameChannel.push("change_direction", {body: 3});
            break;
        case 39:
            console.log('right');
            //player.direction = 0;
            gameChannel.push("change_direction", {body: 0});
            break;
        case 40:
            console.log('down');
            //player.direction = 1;
            gameChannel.push("change_direction", {body: 1});
            break;
    }
  };

  gameChannel.on("change_direction", payload => {
    player.direction = payload.body;
  });

  return function(){
    console.log(player.direction);
    switch(player.direction){
      case 0:
        player.x = player.x+1;
      break;
      case 1:
        player.y = player.y+1;
      break;
      case 2:
        player.x = player.x-1;
      break;
      case 3:
        player.y = player.y-1;
      break;
    }
    ctx.fillRect(player.x, player.y, 2, 2);
  }
}

var refresh = step(ctx, player1, gameChannel);

window.setInterval(refresh, 10);
*/
