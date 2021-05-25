<div id="matrix">
  % for i, row in enumerate(matrix):
  <div class="row">
    % for j, cell in enumerate(row):
    <a href="http://localhost:8080/move/{{i}}/{{j}}">
      <div class="cell" id="cell_{{i}}_{{j}}" style="background-color: #{{cell.color_code}};">
        {{cell.value}} <sup class="sup_script">{{cell.strategy}}</sup>
      </div>
    </a>
    % end
  </div>
  % end

</div>