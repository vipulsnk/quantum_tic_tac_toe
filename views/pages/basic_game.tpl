% include('pages/header.tpl', title="Quantum Tic-Tac-Toe")

<script>
  let base_uri = window.location.origin
  let strategy = 0;
  let cells_num = 0;
  let first_loc = [];
  let first_color = "";
  let is_measure = false

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
    console.log("measure is: ")
    console.log(is_measure)
    console.log("strategy is: ")

    if (document.getElementById('quantum_b').checked) {
      strategy = document.getElementById('quantum_b').value;
    } else if (document.getElementById('classical_b').checked) {
      strategy = document.getElementById('classical_b').value;
    }
    console.log(strategy)
  }

  $(document).ready(function(e) {
    // your code here
    if ({{winner}} !== -1){
    setTimeout(function() { alert("winner is " + {{winner}}); }, 500);

  }
  $('.row a').click(function(event) {
    event.preventDefault();

    // Remember the link href
    var href = this.href;
    console.log("i am getting called!");
    printStrategy();

    // check if want to measure
    // measure else
    // check strategy
    // if quantum, change the color of selected cell and update a variable cells_num to store that 1 cell is selected
    // if cells_num == 2 shoot request
    // else if classical, shoot request directly
    console.log(event.target);
    if (is_measure) {
      console.log("Measuring")
      id = $(event.target).attr("id");
      console.log(id);
      var res = id.split("_");
      console.log(res);
      var loc = [res[1], res[2]];
      window.location = base_uri + "/measure/" + loc[0] + "/" + loc[1];
      return;
    }
    if (strategy == 0) {
      console.log("Classical Strategy");
      id = $(event.target).attr("id");
      console.log(id);
      var res = id.split("_");
      console.log(res);
      var loc = [res[1], res[2]];
      var randomColor = Math.floor(Math.random() * 16777215).toString(16);
      window.location = base_uri + "/c_move/" + loc[0] + "/" + loc[1] +
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
        window.location = base_uri + "/q_move/" + first_loc[0] + "/" + first_loc[1] + "/" +
          second_loc[0] + "/" + second_loc[1] + "/" + first_color;
      }
    }

  });

  });

  function updateMeasure(element) {
    is_measure = !is_measure
    if (is_measure) {
      element.style.backgroundColor = "#008CBA"
    } else {
      element.style.backgroundColor = "#4caf50"
    }

  }

  function simulate() {
    window.location = base_uri + "/simulate";
  }
  function reset() {
    window.location = base_uri + "/reset";
  }
</script>

<div class="strategies">
  Strategies:
  <input type="radio" id="quantum_b" name="strategy" value=1>
  <label>Quantum</label>
  <input type="radio" id="classical_b" name="strategy" value=0 checked=true>
  <label>Classical</label><br>
  Actions:
  <button onclick="updateMeasure(this)" id="measure_button"> Measure </button>
  <button onclick="simulate()" id="simulate_button"> Simulate </button>
  <button onclick="reset()" id="reset_button"> Reset </button>
</div>
<div class="instr">
  Instructions
  <ol>
    <li> Play in Classical strategy to get a feel of normal tic-tac-toe</li>
    <li> On any move, select quantum strategy and select two cells</li>
    <li> So you are at two positions simultaneously</li>
    <li> To find out where you will collapse, click measure and select any one of the two selected cells</li>
    <li> Now hit simulate</li>
  </ol>
</div>
<div class="stats">
  Stats
  <p id="turn">
    Player {{turn+1}}'s Turn
  </p>
  <p id="winner">
    % if not (winner == "-1"):
    Winner is {{winner}}
    % end
  </p>
</div>



<div class="circuit_diagram">
  <h3>Circuit</h3>
  <img src="/static/img/circuit.jpeg" alt="circuit img">
</div>



% include('pages/game_view.tpl', matrix=matrix)