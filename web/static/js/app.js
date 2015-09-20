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

var c = document.getElementById("board");
var ctx = c.getContext("2d");


var Player = function(name, x, y, direction){ return {name: name, x: x, y: y, direction: direction};};

var player1 = Player("Christophe", 200, 200,0);

function step(ctx, player){
  document.onkeydown = function(e) {
    switch (e.keyCode) {
        case 37:
            console.log('left');
            player.direction = 2;
            break;
        case 38:
            player.direction = 3;
            console.log('up');
            break;
        case 39:
            console.log('right');
            player.direction = 0;
            break;
        case 40:
            console.log('down');
            player.direction = 1;
            break;
    }
  };

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

var refresh = step(ctx, player1);

window.setInterval(refresh, 100);
