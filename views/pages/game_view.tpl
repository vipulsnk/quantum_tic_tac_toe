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