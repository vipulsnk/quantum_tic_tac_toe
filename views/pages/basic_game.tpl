<head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<link type="text/css" href="/static/css/basic.css" rel="stylesheet">

<h1>Welcome to Quantum Tic-Tac-Toe</h1>

<script>
  let strategy = 0;

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
// not working below jquery
  $('#matrix a').click(function(event) {
    // Remember the link href
    var href = this.href;
    console.log("i am getting called!")

    // Don't follow the link
    event.preventDefault();

    // Do the async thing
    startSomeAsyncThing(function() {
      // This is the completion callback for the asynchronous thing;
      // go to the link
      window.location = "https://jquery.com/";
    });
  });
</script>


<div class="strategies">

  <input type="radio" id="quantum_b" name="strategy" value=1>
  <label>Quantum</label>
  <input type="radio" id="classical_b" name="strategy" value=0>
  <label>Classical</label><br>
  <button onclick="printStrategy()"> printStrategy </button>
</div>

<div class="stats">
  Stats
  <p id="turn">
    Player {{turn+1}}'s Turn
  </p>
</div>


<div class="actions">
  <a href="http://localhost:8080/reset">Reset</a>
</div>



<div id="matrix">
  % for i, row in enumerate(matrix):
  <div class="row">
    % for j, cell in enumerate(row):
    <a href="http://localhost:8080/move/{{i}}/{{j}}">
      <div class="cell" id="cell_{{i}}_{{j}}">
        {{cell.value}}
      </div>
    </a>
    % end
  </div>
  % end

</div>