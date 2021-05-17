<link type="text/css" href="/static/css/basic.css" rel="stylesheet">

<h1>Welcome to Quantum Tic-Tac-Toe</h1>

<script>
  function onMove(row, col) {
    console.log(row, col)

    document.getElementById("turn").innerHTML = {{turn}}
    document.getElementById(createCellId(row, col)).innerHTML = row+col
  }

  function createCellId(row, col) {
    return "cell_" + row.toString() + "_" + col.toString()
  }
</script>



<div class="stats">
  <p id="turn">
    {{turn}}
  </p>
</div>




<div id="matrix">
  % for i, row in enumerate(matrix):
  <div class="row">
    % for j, cell in enumerate(row):
    <div class="cell" onclick="onMove({{i}}, {{j}})" id="cell_{{i}}_{{j}}">
      {{cell}}
    </div>
    % end
  </div>
  % end

</div>