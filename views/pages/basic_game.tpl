% include('pages/header.tpl', title="abcd")

<script>
  let strategy = 0;
  let cells_num = 0;
  let first_loc = [];
  let first_color = "";

  function onMove(row, col) {
    console.log(row, col)
    var requestOptions = {
      method: 'GET',
      redirect: 'follow'
    };

    fetch("http://localhost:8080/move/1/1", requestOptions)
      .then(response => response.text())
      .then(result => console.log(result))
      .catch(error => console.log('error', error));
    //document.getElementById("turn").innerHTML = {{turn}}
    //document.getElementById(createCellId(row, col)).innerHTML = row + col
  }

  function createCellId(row, col) {
    return "cell_" + row.toString() + "_" + col.toString()
  }

  function selectStrategy(btn, strat) {
    strategy = strat
    var property = document.getElementById(btn);
    count = 1
    if (count == 0) {
      property.style.backgroundColor = "#FFFFFF"
      count = 1;
    } else {
      property.style.backgroundColor = "#7FFF00"
      count = 0;
    }
    if (strat == 0) {
      console.log("Classical Strategy")
    }
    if (strat == 1) {
      console.log("Quantum Strategy")
    }

  }

  function printStrategy() {
    // console.log(strategy)

    if (document.getElementById('quantum_b').checked) {
      strategy = document.getElementById('quantum_b').value;
    } else if (document.getElementById('classical_b').checked) {
      strategy = document.getElementById('classical_b').value;
    }
    console.log(strategy)
  }

  $(document).ready(function(e) {
    // your code here

    $('.row a').click(function(event) {
      event.preventDefault();

      // Remember the link href
      var href = this.href;
      console.log("i am getting called!");
      printStrategy();


      // check strategy
      // if quantum, change the color of selected cell and update a variable cells_num to store that 1 cell is selected
      // if cells_num == 2 shoot request
      // else if classical, shoot request directly
      console.log(event.target);
      if (strategy == 0) {
        console.log("Classical Strategy");
        id = $(event.target).attr("id");
        console.log(id);
        var res = id.split("_");
        console.log(res);
        var loc = [res[1], res[2]];
        var randomColor = Math.floor(Math.random() * 16777215).toString(16);
        window.location = "http://localhost:8080/c_move/" + loc[0] + "/" + loc[1] +
          "/" + randomColor;
      }
      if (strategy == 1) {
        console.log("Quantum Strategy");
        // console.log(event);

        if (cells_num == 0) {
          var randomColor = Math.floor(Math.random() * 16777215).toString(16);
          $(event.delegateTarget).css("background-color", "#" + randomColor);
          console.log("First location selected");
          cells_num = 1;
          console.log("Select one more location");
          id = $(event.target).attr("id");
          console.log(id);
          var res = id.split("_");
          console.log(res);
          first_loc = [res[1], res[2]];
          first_color = randomColor;
        } else if (cells_num == 1) {
          console.log("Second location selected");
          $(event.delegateTarget).css("background-color", "#" + first_color);

          cells_num = 2;
          id = $(event.target).attr("id");
          console.log(id);
          var res = id.split("_");
          console.log(res);
          var second_loc = [res[1], res[2]];
          window.location = "http://localhost:8080/q_move/" + first_loc[0] + "/" + first_loc[1] + "/" +
            second_loc[0] + "/" + second_loc[1] + "/" + first_color;
        }
      }

    });

  });
</script>

<div class="strategies">
  <input type="radio" id="quantum_b" name="strategy" value=1 >
  <label>Quantum</label>
  <input type="radio" id="classical_b" name="strategy" value=0 checked=true>
  <label>Classical</label><br>
  <button onclick="printStrategy()"> printStrategy </button>
</div>

<div class="stats">
  Stats
  <p id="turn">
    Player {{turn+1}}'s Turn
  </p>
</div>


<div class="actions" id="acting">
  <a href="http://localhost:8080/reset" id="anch">Reset</a>
</div>



% include('pages/game_view.tpl', matrix=matrix)