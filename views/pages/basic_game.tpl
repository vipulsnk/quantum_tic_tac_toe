<link type="text/css" href="/static/css/basic.css" rel="stylesheet">

<h1>Welcome to Quantum Tic-Tac-Toe</h1>

<script>
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
</script>



<div class="stats">
Stats
  <p id="turn">
    {{turn}}
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
    <div class="cell"  id="cell_{{i}}_{{j}}">
      {{cell}}
    </div>
    </a>
    % end
  </div>
  % end

</div>