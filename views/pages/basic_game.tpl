% include('pages/header.tpl', title="abcd")

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

  $(document).ready(function(e) {
    // your code here
    $('.row a').click(function(event) {
      alert("The paragraph was clicked.");
      // Remember the link href
      var href = this.href;
      console.log("i am getting called!")

      // Don't follow the link
      event.preventDefault();
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


<div class="actions" id="acting">
  <a href="http://localhost:8080/reset" id="anch">Reset</a>
</div>



% include('pages/game_view.tpl', matrix=matrix)